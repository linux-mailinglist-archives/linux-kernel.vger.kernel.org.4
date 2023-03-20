Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478AD6C148E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjCTOUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjCTOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:20:41 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482331F90A;
        Mon, 20 Mar 2023 07:20:40 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:20:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679322035; x=1679581235;
        bh=Dmhog20iBUZbWLHdDfWPuDym03XHsQpEGJZmSokUkhs=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=bOBc1Qqc1hJ7SRQjbYpnVS9Y4ez8o1BnNVp92nWnVv/HQeoNATB+XtTSprXG2c9i1
         MvDlgkrE03B4+yyrTyTvEjfkM8aKTTK4vm5JkCMTFSn4BRvy1G/tIbwC6GcRmfWYm3
         cXAi4demotevSBAIJ6CNmmWEkk3ufr7P7RjP3gJzojr4pV2nW74VOl/fRfAcy5QNfT
         gWeLRgmYlH1nThIe+yfOSOax3eCqaxWLYhOE5t/bPBxBhS1X/c7fpFt2bDb313jLLg
         1PxyduFzXmVrW8in0TCmIP+GohZcUossC7eQqogP4Wa5MDd8GA7gYcIpdxvstdjuAV
         SNLHuHw2N2hPQ==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/2] leds: aw2013: Add vdd regulator
Message-ID: <20230320141638.3378-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for a "vdd" that is enabled by the aw2013 driver so that
the regulator gets enabled when needed.

