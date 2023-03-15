Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4436BB57B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjCOOEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjCOOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:03:56 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89CB3252B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=S8FRh2fdEySeTuVNy2G2DpxhhNzHIuGyovD0Adxmk9M=;
  b=rw2ub4l8h344ew84Q7SFrr4PYtBdljqtrSYeMb7PO6+At1OGfU+XkPVA
   4qKSy/om4PFm9twk8g47/msHH9IAswDUuu8Btc+ivD8Omdbe5jyaZp4EN
   tpp7M/R96pjPB4qffN+7xUBbPcQW3vFJn4i74wWTuEY100nJArWqR3pG2
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,262,1673910000"; 
   d="scan'208";a="97372873"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:03:44 +0100
Date:   Wed, 15 Mar 2023 15:03:45 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        martyn@welchs.me.uk, manohar.vanga@gmail.com, zoo868e@gmail.com,
        jerrykang026@gmail.com, cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 2/2] staging: vme_user: remove unnecessary blank
 lines
In-Reply-To: <3c194568de78d1c551afe2b8b079a27867f906d2.1678888612.git.eng.mennamahmoud.mm@gmail.com>
Message-ID: <33aa45e-62bb-5b46-c297-fc1676bd1efe@inria.fr>
References: <078be1ba242950f31d0aa13fe9815d92fe96468b.1678888612.git.eng.mennamahmoud.mm@gmail.com> <3c194568de78d1c551afe2b8b079a27867f906d2.1678888612.git.eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Mar 2023, Menna Mahmoud wrote:

> remove unnecessary blank lines before a close brace
> as reported by checkpatch script
>
> "CHECK: Blank lines aren't necessary before a close brace '}'"
>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
> change in v2:
> 	edit commit message
> ---
> change in v3:
>         edit commit message
> ---

You only need the first ---

julia

>  drivers/staging/vme_user/vme_tsi148.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
> index bfa604043355..2f5eafd50934 100644
> --- a/drivers/staging/vme_user/vme_tsi148.c
> +++ b/drivers/staging/vme_user/vme_tsi148.c
> @@ -1023,7 +1023,6 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
>  err_res:
>  err_window:
>  	return retval;
> -
>  }
>
>  /*
> @@ -1741,7 +1740,6 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
>  				  list);
>  		prev->descriptor.dnlau = cpu_to_be32(address_high);
>  		prev->descriptor.dnlal = cpu_to_be32(address_low);
> -
>  	}
>
>  	return 0;
> @@ -1773,7 +1771,6 @@ static int tsi148_dma_busy(struct vme_bridge *tsi148_bridge, int channel)
>  		return 0;
>  	else
>  		return 1;
> -
>  }
>
>  /*
> @@ -2220,7 +2217,6 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
>  	}
>
>  	return 0;
> -
>  }
>
>  static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
> @@ -2530,7 +2526,6 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	kfree(tsi148_bridge);
>  err_struct:
>  	return retval;
> -
>  }
>
>  static void tsi148_remove(struct pci_dev *pdev)
> --
> 2.34.1
>
>
>
