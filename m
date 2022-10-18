Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D73602FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJRPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiJRPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:45:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3448AA223F;
        Tue, 18 Oct 2022 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666107900;
        bh=Jt9NmyfGUJIYwUHCzEW8eHOdjWosSSdsIWzKAGgNkII=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=af4k8kmuydlKzRPaqGcg5kxLEtku1l3NBrtQiBu2TBbes+tESXccMaDzhjRcXAmWO
         I0l2raeeldApHJXHqe+ikRsse1uMppCUMT0Nc1N4BkO8Fi0wvv4byyTP3h/1mT/oYe
         6Zj51rAOvllZR7X6oyP/XvMffcaa4TiaUYwTgF9I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.116] ([80.245.77.116]) by web-mail.gmx.net
 (3c-app-gmx-bap38.server.lan [172.19.172.108]) (via HTTP); Tue, 18 Oct 2022
 17:45:00 +0200
MIME-Version: 1.0
Message-ID: <trinity-8fe25643-9cf4-4f09-bebb-208570a540d4-1666107900051@3c-app-gmx-bap38>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re: [RFC v1 02/12] dt-bindings: PCI: mediatek-gen3: add support
 for mt7986
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Oct 2022 17:45:00 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <684c5659-0691-6534-1602-6c0a53e6e503@linaro.org>
References: <20221017104141.7338-1-linux@fw-web.de>
 <20221017104141.7338-3-linux@fw-web.de>
 <684c5659-0691-6534-1602-6c0a53e6e503@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:PMOh3tpLUMdJNWND3roFSaz6NdXp/BM0p9g+fEsaYUCyloExNRoiqxoIPHwvPXVjpVM0z
 0B5l1TzUaZ0CvFNKNRCUuE8US/Xs1UjdwtXKEBnhpHWRHi68JRTvBJd7x1V+fd81vJ86syjRsTcs
 YEQjSw2iNQndlmMfMuZfUVauKCjVairtdw6kOemtuJiDNzarIhRNAOYNAwkHAA2koGgd/KINNjgt
 nsCz4Rpd8DBsU3vx7wS5H3k9CwMzPP9AkSmzbMQMCi6K3W2jl/6Vwj+c7VyhzNl8TXy3aNQgLYEf
 hI=
X-UI-Out-Filterresults: notjunk:1;V03:K0:G7hCPfXsN6k=:TmCjYiVy2SSY1kL8mfwEFj
 JFWGn2gp0L3NVnE9OVdn2BATvK+qouS+Okg3iLkffGumPDUGbZ2g19ZaLTb1FF5JdPGB8NSdJ
 e5vm/bYfhd8QrFCyYQ5KhCX2QGTK99urFaI1QAudQtmDh/w9vgUmbAQyB4LZZ2IX/Hiu5Sp8X
 kL90zQ5Brgn+/Os/+l7AmK6JuESqeYe0P3OsleBVo5zwMnzDephXKIMihGrCZS+ayvsqZ62XW
 46nZYR95XAcC7PA8pa0OaHEUDTvPYKRJ0J+TAwYoyNRvdp7VBx+3LlHSvII16ad6GGuZD/xvw
 geTwgsoWjkw1mJ1/Lgzvc4Lx+ycqWUGhYq5APrP6RiZfRwJV26dtZPtcAa9UEII9dQHE7wmK8
 HyDd+dIVoAWOwl5YtEAfl1c2YwwaG7lXLXM8QMnqEqzYyYvGXW16J7r9p8kqfyX6nIonrOJ6e
 bunYg+PGn/16CAqPc1ojiKVoQqwddIycVyPxbps4BTHqa5AKfe4PZTtdD23jHY88c+xBwEQmd
 Vx/FtPVepTWuLBlJywrqJ0wBVIHlAQtkq6Ni8ujbu8v47c41erwK1ZV81F1X1uRN4L9+e19+c
 K8d28j3OMMFwrLk6CN2uiGipWjRDNTAO6M4R/tg6xqjQXBJ0ey3LErS1HFO3R4oadeNg0XEPO
 yWKbCy5kNkRpRb2atxmQSBxBAiBYrJTzDM2qmXbdc13kWyH/DgthnXjPiBC7Ur3ofq+yZOb6E
 Cwpgxck+HkVRbFBn+Sr/heQjJq2ZOqpOkKqZsClqadiqTregIMqVeXRYYPjkBkjZMAq8JPz5w
 bOKk+Z2gwJQyR0BOH45XEvFIFQ6Y+aIFMB/azazxk7NT5vUHYrT+/5W81FDyjVeAv/bib/T4g
 F+yvK/zPR8f55bobu0NAggeEYm97FSvfl0iSZZmnNFRXL6CMq3clwDu5q7VrefUR5YoydGAQG
 VlTt7Fc8Pcc6paQDMkWm3woMxhLjtR7A06/C9SdGh4TCb5tDA/xt8tlx3DjSkTuDSaG0iy2KU
 Ope2usjZzJdeYbfK3iHJp4eskuL3LG0dNyPQar/Q85AG13JOIjDIjsvYGUJsATdhN721XF4k+
 tOFfqECcmqe10SCGKRGv/6xpFz9F/8eygo2TWz0rcddVZI8TvmCllUjgKWpkMKuvBn7D+A7tA
 /BgSORrCMk3HZQb8VwPXQBVpNA/+/+bfN8402Ug/VqaA1gn2swCwiUawi31pSizKwty0rXO5b
 kd+A+nCtluUwcnMiJ86TGv5xK9f7NrwgLMcAiTbuGOFdo4n3lcLN0zWRYWbFvcwNlpBpenlWg
 uWUWldxT
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Gesendet: Dienstag, 18. Oktober 2022 um 17:35 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> On 17/10/2022 06:41, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>

> Maybe the clock is not required on mt7986?

yes, mt7986 does not have all clocks currently defined in binding for gen3=
-pcie (currently mt8xxx)

the mapping is as followed:

CLK_INFRA_IPCIER_CK: peri_26m
CLK_INFRA_IPCIEB_CK: top_133m
CLK_INFRA_IPCIE_CK: pcie working clock from SoC, in MT7986 it is equal to =
tl_26m + tl_96m + tl_32k in MT8192
CLK_INFRA_PCIE_SEL: clock mux to select source clock to CLK_INFRA_IPCIE_CK
CLK_INFRA_IPCIE_PIPE_CK : pcie working clock from PHY, pl_250m

as far as i see the driver only enables the clocks in bulk (no access to t=
he clock-names), but binding needs the names

got it solved with help from mtk (see my comment on part 7) with filling m=
issing clocks with a fixed-clock-node.
If this is the right way this binding-change is enough ;)

> Anyway, for the bindings:
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

thx

regards Frank
