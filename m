Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4242661DFE6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 02:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKFBbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 21:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKFBbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 21:31:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5335DC74E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 18:31:20 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q1so7514009pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 18:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y260yV0KwzJMWztWomChr6XjkeANTGLTQ4tvjJ0MEjo=;
        b=TKEydQ03RMa9QtlYHQ9kam9/7IjjTELFUI/eVsEkFh4B/POIx4PVxpouMU/TygwM49
         5gybcTx+bVhWT/9qwQ6ZmX0PaW1RXr5EGrso6CB8oan/CLh/aA9wQN3pSIUiYaC3Vdwz
         01ebZmoGdeV8KE2zfiDT8M6W/aPMhQ11yxbYHNADCe3MIcfy5oZ4H6KkAs9zgdY+flsG
         v724YyrQ5HEKHT/0YLSg2C9xEwO8L8oSkIRFP7U2aj4ir5Af1VjYL8J04QEGqeOabhRy
         gW2mY3xo4/cixkeayWZyC0Bo+K7l7y8O6uywq9NuwnqYa0Jo8Wa0gQnrJM93HL1uUWRc
         3+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y260yV0KwzJMWztWomChr6XjkeANTGLTQ4tvjJ0MEjo=;
        b=xw64rxhwjnttaQJudht3GTOZtztJ9Hn5UCGQ9Kzh523nQTfoHHOR420OVGjWyDGSBd
         mkamGxtzTj8H23sKC/YB5xKiw8mZoZf7oCH2jPuufmzFzNRJPMPRjGMLgps0pA90F1+U
         uyPRZX/PcDYi5v8zgRQIhnLOCqjJ6fKr3OYBYnof9ASYkK8N/tSK8yzzJ1s8zTRUE9Ax
         EZy1JHxet/zVjNnEkm6vWfJrk2zJDQlODQ2dS+Wp6BfnKnKt/3zJSMs1MlD1XMHzDwVm
         5GWRnL838+UUcedHJYPNxRIxqrKJ5Fi5lDzRR6OLcTITjXInsSUBRLiLiPfdh8/54bpQ
         e58Q==
X-Gm-Message-State: ACrzQf0zWCkKXTUueoxzffoH+u3ZHAa5ITVbiAkfYtA+BSYjxT07b7Xb
        DgSqvdSYCW8ar/DYyF/U+ZuKIR6JevJK8N8Y
X-Google-Smtp-Source: AMsMyM7bDzOsLshdLnslU7hfHneEU9XmmUErBS7/0F3Xr8MF+F79KkRN/O7mSQ/i0AcWZrtaMl/lnA==
X-Received: by 2002:a63:f50e:0:b0:470:274b:53a2 with SMTP id w14-20020a63f50e000000b00470274b53a2mr12034698pgh.524.1667698279843;
        Sat, 05 Nov 2022 18:31:19 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a12ca00b0020dda7efe61sm3686468pjg.5.2022.11.05.18.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 18:31:19 -0700 (PDT)
Date:   Sun, 6 Nov 2022 12:31:15 +1100
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: rtl8192e: remove unnecesscary macro
 defines
Message-ID: <Y2cOY/qq8hFrxV+m@jacob-Ubuntu>
References: <cover.1667694826.git.jacob.bai.au@gmail.com>
 <6cdf838429ca9b553fb572f55a53ec25fa4e5f6a.1667694826.git.jacob.bai.au@gmail.com>
 <8fea8008f0ebb85d7e893513117347712e68fba5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fea8008f0ebb85d7e893513117347712e68fba5.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 06:18:41PM -0700, Joe Perches wrote:
> On Sun, 2022-11-06 at 12:11 +1100, Jacob Bai wrote:
> > remove useless macro defines
> []
> > diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> > index eabb4187d907..aad1842857c0 100644
> > --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> > +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> > @@ -307,12 +307,12 @@ void rtl92e_config_mac(struct net_device *dev)
> >  	struct r8192_priv *priv = rtllib_priv(dev);
> >  
> >  	if (priv->bTXPowerDataReadFromEEPORM) {
> > -		dwArrayLen = MACPHY_Array_PGLength;
> > -		pdwArray = Rtl819XMACPHY_Array_PG;
> > +		dwArrayLen = RTL8192E_MAC_ARRAY_PG_LEN;
> > +		pdwArray = RTL8192E_MAC_ARRAY_PG;
> 
> Perhaps use ARRAY_SIZE instead.
>
As the other drivers under rtlwifi are using ARRAY_LEN or ARRAY_LENGTH,
maybe it's better to keep the same format?
