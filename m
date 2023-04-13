Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB46E0F01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDMNka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjDMNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:39:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A2B468;
        Thu, 13 Apr 2023 06:37:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d7so30249026lfj.3;
        Thu, 13 Apr 2023 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681392979; x=1683984979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UdVc/CdRqTsAPMTneSc5uPsE4oqW6L0MUPOzq+mBBA=;
        b=gLfwzR7GLG5SIjghdOUeVSkcPGAL7ABsNHQ3Eq1Dgt5jbo0CVchsU4HB4h45w+N9An
         nQELKedjLB+c2lEZOm87PvNwjcvlOMKikNiKCEfkk1Wi/sNbwUicNrA1OiFtAGy6UDF+
         Wwj3McbgnV9cd5+dLqN0PWgfRzd12dY4+qJAbZUODPYmWFiezpWf1KkUVPE/5w5a9Cz5
         qrbhNeYcMOMSxwoMA0ZaKBk08Uw1mVHugJrgR0mKOrWSdfrzjWdRex8gKXPjch/CTpG9
         Ih+cpiXnFnewYeQgyzaUh2zrLSWk/ux4YawSnZuTVNqSSU9lEs1oJdbV+52CdBTNlJwi
         M/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392979; x=1683984979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UdVc/CdRqTsAPMTneSc5uPsE4oqW6L0MUPOzq+mBBA=;
        b=F1CRSF7ztJatFICtB6cNRC0G4RgtxO3NoDl5exXGnAI7RuZYYAxkVM4BfZVgrdeLIn
         MCkAvvsXJZHpIu3RR/RvaLlpPSIoe8IugZJrG7YdHAK6XIEEFMR9jf0ImEHYtTJRRgwG
         bEDpZ77zylzoAyX3iYm11aR7MyeuwSmihXuUE8sffmgQpthGymmWl5oH5UMay/ihZBMR
         0qBSvyp6f51H+p4b0EnskSTVfvbPoNAMFhUc5BLfqZpaRsVEg8E187dvAcYCcUk/xRhE
         YFebAJ2sM0saHK9c96nh9etT6q6gvUmyR66lam8021EhqSMeWoGObT4kHS/HkhnjAKDB
         7iFA==
X-Gm-Message-State: AAQBX9cETWYkeiO3cgivBWs4moFJANVJpiuPh5xmr/zKH3XSOyejo06B
        A/XzsRkeyoI/wBLaP7WsVeA=
X-Google-Smtp-Source: AKy350bFDzO6EkU7bVc5Ks3w31uJ6I1br+TNFE2s2g24ug36uS8tkFSUqxQ2dV7zGF9dAHwhoH7MjA==
X-Received: by 2002:ac2:548d:0:b0:4eb:f45:3fbd with SMTP id t13-20020ac2548d000000b004eb0f453fbdmr948799lfk.40.1681392978851;
        Thu, 13 Apr 2023 06:36:18 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id v4-20020a056512096400b004ebae99cc1dsm315823lft.159.2023.04.13.06.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:36:18 -0700 (PDT)
Date:   Thu, 13 Apr 2023 16:36:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 2/2] spi: dw: Add dma controller capability checks
Message-ID: <20230413133616.mlmy3flnsic4577q@mobilestation>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-3-joychakr@google.com>
 <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
 <CAOSNQF0R7p7kW04w0nKF2egv1+8NrMhSXpggunYhjQnA+v-qMQ@mail.gmail.com>
 <CAOSNQF2zg5ymTfZWWbFLAgvKdcxRcggAjGt+Zy+qUzrR5=MERw@mail.gmail.com>
 <ZDV5iqj5vbzO5oPU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDV5iqj5vbzO5oPU@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:15:22PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 11, 2023 at 08:37:33PM +0530, Joy Chakraborty wrote:
> > Sorry I think the emails crossed.
> > 
> > So as per the discussion, are these the possible changes:
> > 1> Move "dw_spi_dma_convert_width" to avoid forward declaration .
> > 2> Update the commit text to include more explanation.
> > 3> Divide this into 2 patches?
> 
> Seems okay to me.

To me too.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
