Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4CF6CAB2C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjC0Q7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjC0Q7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:59:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F9930D6;
        Mon, 27 Mar 2023 09:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63172B817AE;
        Mon, 27 Mar 2023 16:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E37EC433EF;
        Mon, 27 Mar 2023 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679936378;
        bh=iX6xV1/d1zdpnc1oyrBq9Ygc5V6FknfTfC9oyWjOAA8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GyaQFUv4KBrA92HoxGy6rqmiMKzRKyEfm6ALYYGiCcrmBTLv8HsbhWNvx0uT/fx+i
         GdTuaDV/8ZM8v4fSuYqlxQlGgdlph44zIPUVVOOW9r1LJwXZ2TfpW55UHW/eHqkP9K
         570rpFId/sUu2qIkG2ZVTLTpzi9hg194iHcQ5RZEsUsEG976rByQrlJVNfedPpfNly
         +wNuG0AipoxxyBxSh6ZMHJ+ELmxGuACUlOL85LBgFrrkgBky6wpFfo0tf50snk2TyZ
         wzgCwoATYaTyppdKLQTmOvMYrw/7iiaJDMrowmNO2c38eklJXzaX0gjcH1eIlRZiio
         0KTNAZMl4Ss5g==
Message-ID: <5e2e9442d232444fcb8630f178f228e8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230323121437.28239-1-lukas.bulwahn@gmail.com>
References: <20230323121437.28239-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in MIPS/LOONGSON1 ARCHITECTURE
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org
Date:   Mon, 27 Mar 2023 09:59:35 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lukas Bulwahn (2023-03-23 05:14:37)
> Commit c46496119ed0 ("clk: loongson1: Remove the outdated driver") removes
> all files matching the pattern drivers/*/*/*loongson1*, but misses to
> adjust the file entry for MIPS/LOONGSON1 ARCHITECTURE in MAINTAINERS.
>=20
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about=
 a
> broken reference.
>=20
> Remove this file entry in MIPS/LOONGSON1 ARCHITECTURE.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Applied to clk-next
