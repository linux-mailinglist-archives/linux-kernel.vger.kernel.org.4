Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6F263D529
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiK3MCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiK3MB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:01:57 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855570449;
        Wed, 30 Nov 2022 04:01:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C0435C0093;
        Wed, 30 Nov 2022 07:01:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 30 Nov 2022 07:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669809713; x=1669896113; bh=TTkNEhJR7O
        4zUmxF0Wpa+N5149VVce2BZS1h+pNlXgc=; b=ESOIaGh0CDOM/2yrieg/3Pkrrz
        3mNCw7HNYPFpjEPlt/8GlnGvIosvT7gqQfRpkjksNr/tDkCtn/utMxYENExJOZwj
        X3CdCbm3/Ns70xAQO/diE/SAW/s6o3KBQG+UQ+JrK/A2Aq2O0QfknURTjhgn0+o7
        ZmSJwVpLX63sarHjDCKYbfMMI5/KbNlrZ11C9I2S/hLJiI25t2Ta6YuYH+iq8FHh
        +W4koAvbSoiD91zgIBigioIEVRfexyPQ3b2XJ+7fpQISFMAt4TwNeo+ucWQGOgp8
        RxJayjWe17eaIiY6dJ8/YISMcs/q4XBVKGhvjaeGrh4UwOGDXUyEE0RihCIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669809713; x=1669896113; bh=TTkNEhJR7O4zUmxF0Wpa+N5149VV
        ce2BZS1h+pNlXgc=; b=Ul/0cxzhY1o77ALyJzS8kcYtbOyd9taSDpfWmSniSUVM
        NV989DBWoX8ejL6X63E1jhWNI58h4dk75mBdGE/pb4IzU502y/smjlATbi1tGDZN
        uRlwdcCErs6O7XXaE9e7E+ljp5J7zWZ0zC9wDilfW5ZaQ5MgoDpXdq5k1VtSnXqV
        FPL7uO4I3HShC7tnXI9f64WTVSHTTJZvXFOPT6siCuV6ueNmzgljwOYun0nqbhW5
        YdBOFtdsAMFdGFxIQqSYBH90xNNGhiWdvOa1QgfI+ipN0LDsYr6BDMmFpz66BPp+
        htMIqZPeKmWL1npz6D1iefiETy3otwyr0BD6HPM/YA==
X-ME-Sender: <xms:MEaHY7HmzX6Q2a8SP7GYvEJFzXtm-F1_tx-eI9jBdTB3qwHxsHufog>
    <xme:MEaHY4VbEGzb6XlbZazm-MKpeJNEeDhVKMGcRuk-6FDKSzl6ROr0YqsCHkF3XsH59
    LPK6RGmj8o_Hw>
X-ME-Received: <xmr:MEaHY9LNLGEyJGmS7IJKoAbxhitwM3T-3f-cf75RqVThIDQ3lic9u4v4csHLlHXJAa56kPJ7DZC3zrs0k34zGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:MEaHY5G6eb8Ox_b1vqCs07SdReMh0qJcQX-ln3epLrbxIkc6n44u1A>
    <xmx:MEaHYxV6Ytz7iCWLf4aVv4GuXhPz3FW1Gmmz4DQlgwfxw5Wg6pp6wg>
    <xmx:MEaHY0N135GfPzudhX34gYs4nvzt6NG4SxtvjvPVM8s0sc--2lXZ-Q>
    <xmx:MUaHY3x0wM5EB1IRpnbyKVayGvxRwO5fKcyIVpAkmtENEKBUYSWaIw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 07:01:51 -0500 (EST)
Date:   Wed, 30 Nov 2022 13:01:47 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <Y4dGKzmLvTDGKySU@kroah.com>
References: <20221130123851.6a9f2242@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130123851.6a9f2242@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:38:51PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> drivers/scsi/cxlflash/main.c: In function 'cxlflash_class_init':
> drivers/scsi/cxlflash/main.c:3890:33: error: assignment to 'char * (*)(const struct device *, umode_t *)' {aka 'char * (*)(const struct device *, short unsigned int *)'} from incompatible pointer type 'char * (*)(struct device *, umode_t *)' {aka 'char * (*)(struct device *, short unsigned int *)'} [-Werror=incompatible-pointer-types]
>  3890 |         cxlflash_class->devnode = cxlflash_devnode;
>       |                                 ^
> 
> Caused by commit
> 
>   ff62b8e6588f ("driver core: make struct class.devnode() take a const *")
> 
> I have applied the following patch for today (please add it to your tree).
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 30 Nov 2022 12:13:00 +1100
> Subject: [PATCH] driver core: fix up missed scsi/cxlflash class.devnode() conversion.
> 
> Fixes: ff62b8e6588f ("driver core: make struct class.devnode() take a const *")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/scsi/cxlflash/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index cd1324ec742d..395b00b942f7 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -3857,7 +3857,7 @@ static void cxlflash_pci_resume(struct pci_dev *pdev)
>   *
>   * Return: Allocated string describing the devtmpfs structure.
>   */
> -static char *cxlflash_devnode(struct device *dev, umode_t *mode)
> +static char *cxlflash_devnode(const struct device *dev, umode_t *mode)
>  {
>  	return kasprintf(GFP_KERNEL, "cxlflash/%s", dev_name(dev));
>  }
> -- 
> 2.35.1
> 
> I also added the following (found using
> git grep '(struct device\s*\*[^,]*,\s*umode_t[^,]*)'
> - please also add this):
> 

Both now queued up, thanks.

greg k-h
