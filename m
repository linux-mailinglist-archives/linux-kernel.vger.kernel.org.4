Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EED6BB50B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjCONq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjCONqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:46:12 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD12311FA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HvGDVV7TPXD0zfYVweAoAgt0ikpvR44Igda4tippI6I=;
  b=Iyv5DNtdbFFvRN9znjf+ot5cj4gg0AESh3T1LHpjWjt/yIQCqQiqWMUv
   hY0RM4UG6qCQyd4U4ZTby53CgGskAo99Tegz/KkjnPssZ/5hJ63af8dq7
   ZqtawvvIotULR9hQC1E8BGXwJIS32mjne8+PJkHlFxxkwqkgO93eDvTBF
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,262,1673910000"; 
   d="scan'208";a="97368145"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 14:45:24 +0100
Date:   Wed, 15 Mar 2023 14:45:24 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        martyn@welchs.me.uk, manohar.vanga@gmail.com, zoo868e@gmail.com,
        jerrykang026@gmail.com, cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/2] staging: vme_user: remove unnecessary blank
 lines
In-Reply-To: <15b80b699315993d7f0da638f805446f6dc0b480.1678887330.git.eng.mennamahmoud.mm@gmail.com>
Message-ID: <dcd9b79-bbd5-f160-317b-7fdd6ca6fc64@inria.fr>
References: <4bdfd864b573c164df30ec738afc93b06ce0d573.1678887330.git.eng.mennamahmoud.mm@gmail.com> <15b80b699315993d7f0da638f805446f6dc0b480.1678887330.git.eng.mennamahmoud.mm@gmail.com>
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
> ----

This should be three -s, not four.

> changes in v2:
> 	edit commit message
> ---

-s aren't needed here.

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
