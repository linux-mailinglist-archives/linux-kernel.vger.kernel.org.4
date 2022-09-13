Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96705B68F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIMHth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiIMHtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:49:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD25A3DF;
        Tue, 13 Sep 2022 00:49:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DBC86601FFD;
        Tue, 13 Sep 2022 08:49:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663055359;
        bh=mD9+p5CeWAabFjztyVRaFCcTYIBpRki8qYznPTDJVbA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m0lJiLGUXAo4Quv7c6czRS5bVuvU8uC2f1jClP6A6drPqz+deYjO9gv0HMKBujiTy
         d9tgiMfaLaFexlr0QHL7mF5M79PHGzLZOOhj9eIxJbH7HjlBpx6nobxm1eNubGmTYu
         F5WwQKqa5gvdT/S8NLu22a6ZpaZyabHgP8iJL7zpZjg03AkMjwHY9IzsyTtwGju/AZ
         60xSLZzDThQbGPliZ3Vil9fbDcE8tF3n52YWrYA2m8sd2XtdJ9dkCvsVe4uSe8VhbY
         AbVhLdTmFG/xAvtAgg+p7/VE0ZnBkEWF7Mlx+rlK6gS41Pw/ObwXa/9v9zxREaowyu
         L5AFScQjtX3dg==
Message-ID: <07016e51-a5b5-a350-cad2-b9fcebfe3706@collabora.com>
Date:   Tue, 13 Sep 2022 09:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/4] Bluetooth: btusb: mediatek: reset the device as WMT
 failed
Content-Language: en-US
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        shawnku@google.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <43b68b1f48c20b1dfcd7e6663c3dcb38e4e0648c.1663020936.git.objelf@gmail.com>
 <a432abf4cf95e93783864b27bafa53d45bdd5212.1663020936.git.objelf@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a432abf4cf95e93783864b27bafa53d45bdd5212.1663020936.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/09/22 00:18, sean.wang@mediatek.com ha scritto:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Reset the BT device whenever the driver detected any WMT failure happened
> to recover such kind of system-level error as soon as possible.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

This looks like a fix, so you probably want a Fixes tag for backport.

Regards,
Angelo

> ---
>   drivers/bluetooth/btusb.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 653f57a98233..dc86726c8271 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2576,6 +2576,10 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
>   	data->evt_skb = NULL;
>   err_free_wc:
>   	kfree(wc);
> +
> +	if (err < 0)
> +		btmtk_reset_sync(hdev);
> +
>   	return err;
>   }
>   

