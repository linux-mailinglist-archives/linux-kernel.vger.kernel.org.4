Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A41D6B8110
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCMSri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjCMSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D77D50E;
        Mon, 13 Mar 2023 11:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B89261469;
        Mon, 13 Mar 2023 18:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850DFC433D2;
        Mon, 13 Mar 2023 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678733222;
        bh=DiUKSAfl3Bq/CEF6Ggysu8vzc21Hp4EjeRcfJXKVHVk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JeIWMLUI8z05oQMUViwuPijU2MIyMYfUpE465mjwrbBPI0VNUxW+dSTyUhtvNaXT3
         fyViynHPh24shmEkKCL9bX8RwUZKCAaWLteqmpCKbtK+bEUEGslIMulmQadWRW8Twq
         OxvwSlvaX4zEJn4zj8iJslRWdVtdr/fU5L1Ssca882Vqf/EfV2FxIpSebabZntj/ya
         KMbnwbZYnhJI4uMzXDCFvP53SKLOI/YRwFw0GgGN0wen99enBaHUShAlgzCsFhw9Lm
         R+jOdAPpEQ+SUFRDzZPzQixOsyqHMoDnOhr2QTJakb0dvqLD1VikMPsdu0ZJWpa6uQ
         VLhc1PkC47h6A==
Message-ID: <e1b513dac9d291423c3b5a193b3acaa4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230206100105.861720-2-angelogioacchino.delregno@collabora.com>
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com> <20230206100105.861720-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 1/7] clk: mediatek: fhctl: Add support for older fhctl register layout
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Mon, 13 Mar 2023 11:47:00 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2023-02-06 02:00:59)
> The Frequency Hopping Controller (FHCTL) seems to have different
> versions, as it has a slightly different register layout on some
> older SoCs like MT6795, MT8173, MT8183 (and others).
>=20
> This driver is indeed compatible with at least some of those older
> IP revisions, so all we need to do is to add a way to select the
> right register layout at registration time.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
