Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9BC6FEB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjEKFKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjEKFKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BFA3A86;
        Wed, 10 May 2023 22:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 895E363A53;
        Thu, 11 May 2023 05:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA92C433D2;
        Thu, 11 May 2023 05:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683781843;
        bh=iFUpQ4D07YSZNO0RTuCRy1luLl+VzUEaBiyc3WJiu8c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=UE1segLWGdZbdEoQ77McrCIOz+FbLlRdwBaCxQsiLp1itu+lnIlvUf5VtI77lCHJH
         UZIG/AMgKf+Mtt7cGCwyIddO8DVWEZL6Mb6UCzo5n8QRNgpW42hKNKPmMpPMgNo09d
         Sf8UNSMDpYocIjWpWS/nUWnqa37xWTlUKMPDqEf3eEQ/8CzS454nCsE5SVacdf5XTt
         StKTJyYJI8Zjf/giCk01Z4zfiHAxTrpGRf2ja174uFeXSq2N7Z7r25cCKoRUFTxf/j
         rDaAu8kquFwDB5pugszTWO5t7y9KnOxA96dK6ycKIm8yJ1Q0nWdk+WhWEx/W09ggdp
         GmdWVFzf+fNow==
Date:   Thu, 11 May 2023 06:10:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: add tdm node and sound card
User-Agent: K-9 Mail for Android
In-Reply-To: <ef13177a-2028-9fc9-628a-e3d287758207@starfivetech.com>
References: <20230506090116.9206-1-walker.chen@starfivetech.com> <20230506090116.9206-4-walker.chen@starfivetech.com> <a0932e84-3813-bbbe-762d-948d75fbcd8a@starfivetech.com> <20230509-overheat-pliable-00d60523637e@spud> <CAJM55Z9AxMVw=ymfFBb=45nODq89O8dMebzRgo-XD0GKduDBYg@mail.gmail.com> <f27b7ee7-f23a-35a2-3b82-71f50871dfcc@starfivetech.com> <20230510-riveter-ridden-3f056251e623@spud> <ef13177a-2028-9fc9-628a-e3d287758207@starfivetech.com>
Message-ID: <CE38599D-24DF-4FD4-8CDF-F1A70673B972@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>I'm trying to understand what you mean=2E so the conclusion is that I nee=
d to drop the file
> 'jh7110-starfive-visionfive-2-wm8960=2Edtso' from this patch=2E
>When I submit the next version, just keep the TDM node and the pins confi=
guration for TDM in patch [3/3],
>need to drop the wm8960 stuff=2E
>Right ?

Yes=2E

>
>Best regards,
>Walker
