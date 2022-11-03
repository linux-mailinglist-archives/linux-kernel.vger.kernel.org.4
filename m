Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1617A6185E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiKCRMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiKCRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:11:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20B1E3C8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:11:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y4so2547777plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyEaiXYwGZ66+eMx05Q+3jfcs0ljEUn1snD5FexMKL8=;
        b=A8fXGXXAcSb8wP6STdb3cm24s8EfdklK5O49e41+AWr+xMmeIcMh3Fa3jgTVN1ZXks
         hLpfF1BKpLP3StIca1AM4j41UaEAXPWH7qMdzzQHXmYG0qFT+nPAYWw4L0bKuJ1B+kNP
         voWIeMOvv7SwoFqzlGJDm0efaNkKZcmRr+Zk98VfWoV8zzRW9yiLUZ1/rzBVcI68bVDc
         fznnlq1+dPNdvGjSexG/PsOZAxivX5KtC3EBe3KQ5HWIs1uQfKMhFwZOPXC8qrVVvrLl
         eyodCLe2TpOK3nLQDX0vITvS4WIPpkUlhCDOfzI56DXe2zURNZmMZ3aNjl8i2yHlZ8tS
         t04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyEaiXYwGZ66+eMx05Q+3jfcs0ljEUn1snD5FexMKL8=;
        b=TDbTyUJpo8TOpZUB57XshemwBD1TEv+JKy7JlWS8gIYFR1LMNEN1RDdbkLxDndN/Et
         /eueoE61rQgkrJF0FJK84BA6FWj0EqQW29S1sPrERYWEHqN8pZ7HxFTT45GiSehrTTl5
         tq300TrzjcziI6r4Nn76xLsbRhnPVTnqx05+UXNDh+6rpwfNM6gy3UHc1Vm+UOPXp4Kb
         JeqeXF4Rd4DBKLI7YxVctOW8Aq8vjtLreclNjkodRONIDQ4EdM3HUzFzLRVf9/cYvqdI
         axlWPygf1Vjk/EZHomclsSp3hRzgRunBeBIPsQCzjLsKTtvjFwzWILISMP+sm+D5xc2D
         Epcg==
X-Gm-Message-State: ACrzQf3DB+uISb2dDk/x1MaVPZ/hNb0lN/1ev+npC6+QozyVjUySRIsp
        tHtpCeZl+kiRQjtaYnNVR9c=
X-Google-Smtp-Source: AMsMyM5Nr6JzpD4MArJro/efIP53SmH1+6Ydpi9jLmS/lV1d1RhxHIShehkJYiPGH0xwvWHOVjouMg==
X-Received: by 2002:a17:903:292:b0:186:dae9:c089 with SMTP id j18-20020a170903029200b00186dae9c089mr30644140plr.31.1667495472577;
        Thu, 03 Nov 2022 10:11:12 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3d65:7dc2:c62a:5d98])
        by smtp.gmail.com with ESMTPSA id j36-20020a635524000000b0046ec7beb53esm1040263pgb.8.2022.11.03.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:11:12 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 3 Nov 2022 10:11:10 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2P2LqG5nzxBvIEi@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2M/DeLwab0o7btv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2M/DeLwab0o7btv@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:09:49PM +0900, Sergey Senozhatsky wrote:
> On (22/11/03 12:05), Sergey Senozhatsky wrote:
> > What is the use case for removal of a secondary algorithm?
> > 
> > > My point is that we don't need to implement it atm but makes the
> > > interface to open the possibility for future extension.
> > > 
> > > What do you think?
> > 
> > So, as far as I understand, we don't have reason to add remove_recomp_algo
> > right now. And existing recomp_algo does not enforce any particular format,
> > it can be extended. Right now we accept "$name" but can do something like
> > "$name:$priority".
> 
> Or with keywords:
> 
> 	name=STRING priority=INT
> 
> and the only legal priority for now is 1.

I like it.
