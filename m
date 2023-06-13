Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA672EA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjFMRo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbjFMRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:44:54 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 10:44:52 PDT
Received: from mx3.wp.pl (mx1.wp.pl [212.77.101.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA8BE6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:44:52 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 16475 invoked from network); 13 Jun 2023 19:38:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1686677890; bh=tqrOnhUqBSSsn9DlIaYHlugnQjEi/zvdG1LzqC/nqdM=;
          h=From:To:Cc:Subject;
          b=ooUufiOF3S/gX2T/vLbzkCkzpOPK9R34asDzgcP8+K/oR+s87L0rWJcMzISXvwgmM
           9iWdwoB9HNvQBQdFkfH6ZL/QAw8yt1NckAMrI+JuUyYj5IhObzoZKRAMhcuMBS5clJ
           JkvOAQREaiGCoOP5Vp9SZdlscRi5EEyZlaL5YhZE=
Received: from 89-64-14-253.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.14.253])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <wangdeming@inspur.com>; 13 Jun 2023 19:38:10 +0200
Date:   Tue, 13 Jun 2023 19:38:11 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     helmut.schaa@googlemail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rt2x00: fix the typo in comments
Message-ID: <20230613173811.GA305477@wp.pl>
References: <20230612114612.1640-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612114612.1640-1-wangdeming@inspur.com>
X-WP-MailID: b0b96eb4450f14852bbf4387fc221b21
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [wVNl]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:46:12AM -0400, Deming Wang wrote:
> Fix typo in the description of 'non-succesfull'.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
> index b052c96347d6..6cf7e7c997c2 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
> @@ -192,7 +192,7 @@ void rt2x00link_update_stats(struct rt2x00_dev *rt2x00dev,
>  		return;
>  
>  	/*
> -	 * Frame was received successfully since non-succesfull
> +	 * Frame was received successfully since non-successful
>  	 * frames would have been dropped by the hardware.
>  	 */
>  	qual->rx_success++;
> -- 
> 2.27.0
> 
