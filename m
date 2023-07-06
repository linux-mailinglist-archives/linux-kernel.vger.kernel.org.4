Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61FC749A98
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjGFL3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGFL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:29:11 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74092AA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:29:10 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1688642946; bh=GaIzuleTk6y38BlblyBELaBaO29snXMMzVOcoUWhQB4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rHMszqHJJ2HjHHIIpVXxCP2sMiXiodRgTi5O9QNUiYqBggvFDx5dP4oaL9fieR4xj
         HjvUKGtxVSMO6NMRfcZHy5c/Mi7FPv7HvFODM11dimmTsllTbjQ3gcpoMZnOiuQUIF
         /uQMn5o9PNhuSn23S9hBJPFIlyD/8GJBXfTgClSf/VB8GqwpOtZm8ZTDZQ7ohWL/VM
         yb5ua48TFu/Q9hirG6opW4kXRQtfe8dmmF83SYmldi5TNUvM57ZfX3w1GFFeOumxSc
         5IAemCe1k/HLmSVCBoZO2sOwkAGyOWOMV3ZhMqXz5oDXohXx3g/CF5C63xGB9Mr0A0
         NUBIEbkTu1rUw==
To:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] wifi: ath9k: fix printk specifier
In-Reply-To: <20230706111700.14305-1-dzm91@hust.edu.cn>
References: <20230706111700.14305-1-dzm91@hust.edu.cn>
Date:   Thu, 06 Jul 2023 13:29:04 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cz15s2gv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Smatch reports:
>
> ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
> ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
>
> Fix it by modifying %lx to %p in printk.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Third time is the charm! :)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
