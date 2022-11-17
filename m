Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F9E62E516
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiKQTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiKQTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:15:06 -0500
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EC14D38;
        Thu, 17 Nov 2022 11:15:05 -0800 (PST)
Date:   Thu, 17 Nov 2022 19:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668712503; x=1668971703;
        bh=UHkvVZhelkt87lb5NxW5b94WAvZpnGxgLmfBH+Voh+Y=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=zlZDbCMP+HCK6Gg+23TVi2Euz3znZ6FE+eFeNGK2glZkksObrzW3N5Oy5DAM4VyFL
         26MxHYtRCjmTxD5yxR8VdszNMsg2CD13DMiaxFXkYI669VV96LG3ICQSp/VRovXHVO
         dxCktZmUCLNtzynRYqYfW/lek/nNYYzmCNbgfk3t5S6rASEAsc24+BF1F5/AbO6t3G
         x0iVcaS2V3uNLVntyKDrSIVIZM7r43XzCsdopnHmBAUrK79jAC7sw9mOxgaNpDI2OW
         gpQADYRuXRILdUAErRVxnHpdtfULUKWF6vAwnapGbKiyawuipcuRdzWXnIaNlaTUQZ
         Jv3HN+blkTQcw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [RESEND PATCH 0/3] Add supports for Imagis IST3038 and IST30XXB
Message-ID: <20221117191436.87938-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds supports for Imagis IST3038 and IST30XXB IC, which are
variants of Imagis IST3038 IC. They have a different register map
(labeled protocol b), but otherwise it seems to be the same IC.
It is also possible to support various other Imagis ICs using
protocol b, such as (but not limited to) IST3044B, IST3026, IST3032,
IST3026B, IST3032B. However, most of them (all except IST3044B)
use a different coordinate format, so extra effort would be needed
to support those.

Tested on Samsung Galaxy Core Prime and Grand Max.

