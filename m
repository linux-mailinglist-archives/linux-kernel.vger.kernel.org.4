Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C0369B7A5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 03:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBRCGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 21:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRCGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 21:06:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207CF5F242;
        Fri, 17 Feb 2023 18:06:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B73F6B82D75;
        Sat, 18 Feb 2023 02:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5E7C433D2;
        Sat, 18 Feb 2023 02:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676685977;
        bh=5xIQ2dHhiBWicvk4sy4hb4AODy+qsSgLqKodHuCFD+M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XczH8us6N2O/a4kQ00+R5STZqwpXbgzsZFhXpjsCkPnMhG7BTsRmR9SRi3eGz6X0m
         sGzmltNIuo3un6GgNTsFrr5YhS0MQvwN6losC8vL4bAWIVgtIMbajdmIXklxKjECn6
         7lFDBs+AUqY3f1vclm7nyZzAXyqANI99vvwClkYekhlwqOmDAMqpPSdTM06H1sIgXi
         JxrxxAJxt4bRtC+uIgRTJEGQTFOxrgNxi2TQ6Tq6oglaMminiz/xWnVhTeX3Ct4LVH
         6okSBjAkcbHsK0XCdzSnOJVJC+BuHCR9XO7v9Utf/tsdMGXFU5VtQuhfZnPTn0/izv
         YKF1C0jQx/Peg==
Message-ID: <734ae9592bfaef54223f74d17fb9dfd8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230202-asahi-t8112-dt-v1-13-cb5442d1c229@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net> <20230202-asahi-t8112-dt-v1-13-cb5442d1c229@jannau.net>
Subject: Re: [PATCH 13/17] dt-bindings: clock: apple,nco: Add t8112-nco compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        =?utf-8?q?=EF=BF=BDer?= <povik+lin@cutebit.org>
Date:   Fri, 17 Feb 2023 18:06:14 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janne Grunau (2023-02-12 07:41:23)
> The block found on Apple's M2 SoC is compatible with the existing driver
> so add its per-SoC compatible.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
>=20
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
