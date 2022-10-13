Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C365FE254
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJMTBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiJMTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:00:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E4A65A6;
        Thu, 13 Oct 2022 11:59:39 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 75CE0660236E;
        Thu, 13 Oct 2022 19:59:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665687577;
        bh=POzrOD83yEQNWuX0sbFvANNKRHVWS/t540l3lHJfAU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maUXxcyiOHdRZ0qzaBWdFFy1AlZNZ8YUwGH5Gj9nXMyaEBapAU/ZJXR+DKAA8nFNx
         kpt8WJ+9209x3S6r48Knwp2xMM8Arqyg0YYXXYIpEbSMKeaUsEEjZMksKITa4PZzp0
         spK1SvgqPZF+zopUp2O/8EBuJwoKkBBhapSKSna8IPVB9HIeqvDNXJn963bgcW72Oc
         XTkIL5z09ZZEYae4Uj4tMQDxhMkUtEEkFQXaz42nJYAIj/vlb1dJwtVXdNcQZORC3C
         lWaOsyq1dcfpvhXJU5iY4FZ3vTFLRFoI78jHzEZ1oUnVxVhPyOSdBS4asVseUUwnb3
         DThJ62qi/neyg==
Date:   Thu, 13 Oct 2022 14:59:31 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 4/5] arm64: dts: mediatek: asurada: Enable audio
 support
Message-ID: <20221013185931.xgtkv3fjuvvzugrb@notapiano>
References: <20221006212528.103790-1-nfraprado@collabora.com>
 <20221006212528.103790-5-nfraprado@collabora.com>
 <CAGXv+5Fz1f2tzxJzYZDtSiXA5H84aF9Uz1vC-dF=ALkNUA3uKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5Fz1f2tzxJzYZDtSiXA5H84aF9Uz1vC-dF=ALkNUA3uKQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 01:31:43PM +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 7, 2022 at 5:25 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Enable audio support for the Asurada platform. This consists of the
> > machine sound card, the rt1015p codec for the speakers, the rt5682 codec
> > for the headset, and the dmic codec for the internal microphone.
> 
> It should be noted that there's a new revision of Hayato and Spherion
> that switch to using the RT5682S codec. These are mt8192-hayato-rev5-sku2.dts
> and mt8192-spherion-rev4.dts in the downstream kernel.

Thanks for the heads up. I'll move the variable codecs out of the common asurada
dtsi for next version.

Thanks,
Nícolas
