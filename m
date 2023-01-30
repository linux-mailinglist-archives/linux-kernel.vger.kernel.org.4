Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375376815FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbjA3QHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbjA3QHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:07:39 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745963FF25;
        Mon, 30 Jan 2023 08:07:35 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 24D786000D;
        Mon, 30 Jan 2023 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675094853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwBxvonceY4P1NbcQ0KVI8q53OO3cIpiyQCxAOt2B3c=;
        b=E/Lv8BGKmuhXTh819UVjZR4InZHKKnezUUdq9dmEaqTBKNxPXBZrcNYnapr40CoWlTAynC
        aor5lY5LDNmjE7AKRzzfI8HK/G9YoYEQNcpiSyri67orHBlhaWzOFRHblxQRYLbZo5Pkaq
        OEmZBLBiimPoZyTA9Uyvv54KDB/9o9f1EZo2VltWNoT7Z0ABOzBLi7FpLzEKRPfrbZS3Vl
        QSgZEyodjzo4q5z5gn3rBsw+aWXelYaVMiJGm7EN7TzVLBVL9E9LEV+FWid791xM+v9iGW
        A0TkT6pD0ajH+q1xYV19TvMpegxPs0OGcd9hgvEuzzVqWYcPy1+NI//jC7V5IQ==
Date:   Mon, 30 Jan 2023 17:07:27 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: partitions: Fix partition node name
 pattern
Message-ID: <20230130170727.04286633@xps-13>
In-Reply-To: <20230120020454.3225796-1-robh@kernel.org>
References: <20230120020454.3225796-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Thu, 19 Jan 2023 20:04:53 -0600:

> The 'partition' node name pattern is missing start and end anchors, so
> anything is allowed before or after the regex pattern. There's no in tree
> users needing that, so add anchors to the pattern.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Looks like my scripts did not properly sent the "applied" e-mail, so
here it is, I applied this patch to mtd/next.

Thanks,
Miqu=C3=A8l
