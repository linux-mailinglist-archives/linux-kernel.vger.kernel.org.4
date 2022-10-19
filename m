Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41F66044CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJSMPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiJSMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:13:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC271C2F20
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:50:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g1so27633985lfu.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qwrn1vs8o0kePTfrmChJo2xK2fUre7OHA6jurV1GYSk=;
        b=iA1lp7ep3qZwe3PuooZkUdm+FeHudibOWXJkUjRZdDjGjza8TwRCMxTAtpyhVkPWuJ
         YkWNkCd4BnPI+x+Qxk/wrbvGrTr77ccoc/GHib4GzOyyRzjNw95wwrTyAcUjsALFLKMZ
         yz8ujzuGAXX+0ZVnMO09/jiwR4hazJdCo1dx1zNiYO1mXnrpCPLmqiiD+e+KWLFu8Oes
         sG6uvFJMLyR3dFem3lTlTUmgotrtpPPclr5opAjp4U8jUpnRh+85EbIRQfKluaQ8N8+J
         /D94dDctYw1T13Oq5ayLD8PQdSFEEwsIe20QR/fZ8/cioW1mjD1FbO9rDa/nf4DwS9ld
         7/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qwrn1vs8o0kePTfrmChJo2xK2fUre7OHA6jurV1GYSk=;
        b=Xh6Ig+WsQVVrXFsPagZr2hZWGPLM6NQpkvYlE2AIhJIsljqGNlXLdSgM0cAJ36ueca
         LdxVmztflk6T8OQvpcx31pG7Va98S74RWW6J95U+74sj3I0SwMb49KQH+ggttVJUrkAp
         8KqkPfsnricGXrY0nHrsVNNSeyon/r72DUSBac6l9f+fWPvTpmuRmaXDVK5GAMCdlBli
         b5MtBdjN/QuiPCxhNGdrQpKOUJHp2uUnH6UHVvqsWhZ/KhtpTSHStRTt3zuzsM3lHRI7
         X5FR71iGmoc24oNWfSbAj5jPMWBTzAeM2Xr8ivT47QISAIUjFnO1YalyZw194DCzAiLQ
         CbFg==
X-Gm-Message-State: ACrzQf3pQWDMqgjjXKWPD/4DAZhjLrCDsrHEIJuhstvevQzJEA/HdvEY
        5rqCPjWWmEb6vbJLfMiZoU8=
X-Google-Smtp-Source: AMsMyM6adnqW8A/S9iID8dTCZ/7syHVDgvsYqxEGqFWDUMPBP8/5y5RDGzIxNkly5zFYVgsL8r7DDg==
X-Received: by 2002:a05:6512:3e2a:b0:4a2:5471:e1f6 with SMTP id i42-20020a0565123e2a00b004a25471e1f6mr2585286lfv.45.1666180165317;
        Wed, 19 Oct 2022 04:49:25 -0700 (PDT)
Received: from pc636 (host-90-235-12-192.mobileonline.telia.com. [90.235.12.192])
        by smtp.gmail.com with ESMTPSA id bj11-20020a2eaa8b000000b0026a92616cd2sm2415549ljb.35.2022.10.19.04.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:49:24 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 19 Oct 2022 13:49:21 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/7] Add basic trace events for vmap/vmalloc (v2)
Message-ID: <Y0/kQWjOTgWCEPg8@pc636>
References: <20221018181053.434508-1-urezki@gmail.com>
 <20221018142302.7af359f5@gandalf.local.home>
 <20221018142509.0b338849@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018142509.0b338849@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:25:09PM -0400, Steven Rostedt wrote:
> On Tue, 18 Oct 2022 14:23:02 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > Description is here https://lore.kernel.org/linux-mm/20221017160233.16582-1-urezki@gmail.com/  
> > 
> > You should always copy the description in each version. It's annoying to
> > have to click a link from a console email client.
> 
> Although, what I do is, include the previous version when talking about
> differences in this version. That way the link to the old series can be
> easily found.
> 
OK. Thanks for the review!

--
Uladzislau Rezki
