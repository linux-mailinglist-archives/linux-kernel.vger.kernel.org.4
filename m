Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9272BC37
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjFLJ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjFLJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:25:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C716B30EC;
        Mon, 12 Jun 2023 02:19:31 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C52566056AA;
        Mon, 12 Jun 2023 10:19:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686561570;
        bh=fNU6scSA2rHkRzEyyBF5v9DMH6F+dEaI8vua4xNrQmw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lDAFXrEd+e7nuA6RDWMgFuJEuYf9S2QS3C4cUwJX390UMLJYaGUl82/uMRmPD1Qf9
         BPVpVGfjPvg+TY0d4O4WmpyVnQ3lZgWQa4XzEW+uiR7nXwBTMVgBj0GcQgovDuGNmD
         e3bTVnzkSNbpYOVqY8EFYFb/LxxTmwU/PnTm7bMAN4VXelDFrXjOymkb9WTAUunhn8
         z7KKdgm+Nbs4kCqWedSma0cgypwUrlWnuJZCoxuNG6ur6cjkf8hcfRp4LRoDhEt3F8
         qsgOCQLUPOuZitDFlTwVXVkRaQZLrk6uF+GVqhLHU3YIgn5SZ9/mafVE0s+RzjuQMH
         dHZZzTUJXdu5g==
Message-ID: <c75f67fb-ce7d-2720-36ac-7b4c64de0cb6@collabora.com>
Date:   Mon, 12 Jun 2023 11:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/2] scsi: ufs: core: Export symbols for MTK driver
 module
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
References: <20230610083321.5566-1-powen.kao@mediatek.com>
 <20230610083321.5566-2-powen.kao@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230610083321.5566-2-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/06/23 10:33, Po-Wen Kao ha scritto:
> Export symbols for MediaTek UFS driver's PM flow and irq handler.
> 
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


