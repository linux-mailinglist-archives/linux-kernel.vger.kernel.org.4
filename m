Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5599566D659
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjAQG3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjAQG3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:29:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A46113D1;
        Mon, 16 Jan 2023 22:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3813B811CF;
        Tue, 17 Jan 2023 06:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A921EC433D2;
        Tue, 17 Jan 2023 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673936952;
        bh=6SD6xx6Ce3uU6UrZd5VeimNx9g3yWB16aIsFtg1yRQI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=cHmsJHh+7Id6jvWSM4EDB6M0/LTSuU6wdoTrXwH+WJS+cYsAJU4dfA+UW6g+/8QqU
         mFUS7GwSty00JecHClVNxmOoWk1qhSs1WcNx/cxc6u2dbapnZ5Ja1mpBZS0O5lbVD4
         bgLV4+IBQtpEgnD9DFVnsD+uJm2kDgBycpYHzCCH6fJtFz6TsVTx4lAnXAnvUe8M86
         dJ2LkdQjrE/IIV54lSdT9znTlj4gv78+01LOpqjfYvgH1XNRQnO4T8UlitBBpinq47
         vci5zSrmsw1LEF05dunUe5wJEnaaze1qkaK+VNJLhvqcC0WC7KwFMlS0bc/PG/LFbC
         XkKgnNDIuEDEQ==
Date:   Tue, 17 Jan 2023 06:29:08 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_0/5=5D_Basic_pinctrl_su?= =?US-ASCII?Q?pport_for_StarFive_JH7110_RISC-V_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <7e641f5e-2d06-43c4-7c9b-9449ef567612@starfivetech.com>
References: <20221220005529.34744-1-hal.feng@starfivetech.com> <Y8BfvQCFNz9KNrDY@spud> <7e641f5e-2d06-43c4-7c9b-9449ef567612@starfivetech.com>
Message-ID: <0305F1B0-4726-4529-9A6F-517D299851DF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 January 2023 02:38:11 GMT, Hal Feng <hal=2Efeng@starfivetech=2Ecom> =
wrote:
>On Thu, 12 Jan 2023 19:30:05 +0000, Conor Dooley wrote:
>> Hey Hal Feng,
>>=20
>> On Tue, Dec 20, 2022 at 08:55:24AM +0800, Hal Feng wrote:
>> > This patch series adds basic pinctrl support for StarFive JH7110 SoC=
=2E
>> > You can simply get or review the patches at the link [1]=2E
>>=20
>> > [1]: https://github=2Ecom/hal-feng/linux/commits/visionfive2-minimal
>>=20
>> Do you intend submitting a new version of the patchset to address the
>> comments about the bindings, or are you waiting for comments on the
>> code?
>
>Sorry for the late reply=2E If no other comments, I will fix the current
>known issues and submit a new version=2E Actually, I am busy with some
>other things recently, and I will reply the comments as soon as possible=
=2E

no worries=2E
Just FYI, it'd be good to choose something like v6=2E2-rc1 as a base=2E
Looks like some header changes have landed
that make the current version not compile=20

Thanks,
Conor=2E

