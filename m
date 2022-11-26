Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723EA6394F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 10:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKZJpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 04:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKZJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 04:45:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2BB1BEAC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 01:45:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o30so5071487wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 01:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fNBK4QqpY340G3XV9v4iOSyaQo0TRWeIslb8zESvqLE=;
        b=EsXgxdwDGtli4wpNVj7WBXbE9x4pV9ASGAdalZffmwJv3ubhkgi5w3kywjoSBubvrF
         FSLpb6nr5AHwpqexI+G6JUD2lYvnyi8JJxwJ+fJbMeZGWI/FOJHI3yvxfXgL4Xetw+ss
         uEdzTVhX2dywawhL8ncFrc5dZ2j2cn0o/UA9rnRYOUpG0VJlCeXjjkz3kXi9JXTbbEmN
         sJDP0yhfNe2EKW5FWwhmx0WOUK/YqgvqKtNiwUXMBR/UnX1iRzsmqQiCf9GlSk9LzZXO
         /Nu+KuPRbW0Z1isrScZ90BvHfUJx4pKtsxC4BjDrKaWrbP7KbnQDZYBPoYWMfdMh+H9Z
         R1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNBK4QqpY340G3XV9v4iOSyaQo0TRWeIslb8zESvqLE=;
        b=lE0LpnehtJAalZWoQ4WXnJnnR0zSSPLbH8r1KuQ0SaZE2/fpcG1FDcWI8W66dowG0q
         j9dbFBihkI81pFvgs0MC3BIt4hILRodmvo/Khf1+z6NdyHVMlrMf4lUYKHtgpnx5QK/S
         rpJNhhV8FLmzvyBEJvau3svLcPUsExmz/AsDOvayycXC3HgaTTsMuuaOHp7gd8Dl4tuU
         L6uJ2kZHz3kxLqb8Arh1QwWTHnZHXGtLgKI70fBJsj4zmOndKzDJSACYde7pxqIA+GWK
         tJTToJusG9sIb3RGO6BN3De3g7+Ko2dl3A4tDSqd5/vbszetOp8/Pj9AcGvQkZyTFa0m
         SKmA==
X-Gm-Message-State: ANoB5pmw7dKfX8OPzDyVqa3ehbmN2pTZRdwXDX2KEp8VqrqC2eLoGOrA
        Xub24i476Bp7GgnVOPOnYTw=
X-Google-Smtp-Source: AA0mqf6d8cfU4hNSGLB0APXRKgv6Kojpb29bspmLAqKJe36EnnZdCMYe0G6qOdGyD3oOdoh6vs3Gtg==
X-Received: by 2002:a05:600c:3c96:b0:3cf:a457:2d89 with SMTP id bg22-20020a05600c3c9600b003cfa4572d89mr33816286wmb.20.1669455901774;
        Sat, 26 Nov 2022 01:45:01 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h9-20020adffd49000000b002383fc96509sm5654788wrs.47.2022.11.26.01.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 01:45:01 -0800 (PST)
Date:   Sat, 26 Nov 2022 12:44:55 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Ekaterina Esina <eesina@astralinux.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Won Kang <wkang77@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] gdm7240: Add check for NULL for callback in r
Message-ID: <Y4HgF21MXyb9YH+h@kadam>
References: <20221123132345.7071-1-eesina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123132345.7071-1-eesina@astralinux.ru>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 04:23:45PM +0300, Ekaterina Esina wrote:
> Before dereferencing r->callback check it for NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> Fixes: 61e121047645 ("staging: gdm7240: adding LTE USB driver")
> Signed-off-by: Ekaterina Esina <eesina@astralinux.ru>
> ---
>  drivers/staging/gdm724x/gdm_usb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> index 54bdb64f52e8..7cf89f4c95c4 100644
> --- a/drivers/staging/gdm724x/gdm_usb.c
> +++ b/drivers/staging/gdm724x/gdm_usb.c
> @@ -409,10 +409,12 @@ static void do_rx(struct work_struct *work)
>  		switch (cmd_evt) {
>  		case LTE_GET_INFORMATION_RESULT:
>  			if (set_mac_address(hci->data, r->cb_data) == 0) {
> -				r->callback(r->cb_data,
> +				if (r->callback) {

What makes you think r->callback can be NULL?

So far as I can see that's not possible.  It is checked before it's
added to the list in gdm_usb_rcv_complete().

regards,
dan carpenter

