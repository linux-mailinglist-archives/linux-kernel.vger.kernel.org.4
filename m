Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE590713404
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjE0Ka7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjE0Kaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E600F7;
        Sat, 27 May 2023 03:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB61C60FA8;
        Sat, 27 May 2023 10:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF2EC433EF;
        Sat, 27 May 2023 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685183453;
        bh=Y9WdoU8Fui6jk1i735LlGzHB3ihXws8six05LZsVyIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kE+NUZHQTI7D4hJf2n8yVq8QOdSCKlsgZD7TDqLbYGAhzcz3KJVPZLA95ljIDN6++
         t5r70899P20OPCacZ3gmRqTn9OiNkuNNuCTeLg3BUO6dXx/hpYE/OqDenvcSn7LIOc
         bFVaDcaNXr5SCrRh+YURSzb9Z3yVdYC2lG86S7P7gk1HtEFP5HsvCKgvNBSizueAu6
         VpBeGsLpjz3XNi3sDpKQvO175uGJ9XrJEEiRRoHEkeC1M/vq9sa/XNkH8bDQed2BGG
         22VNOlqd3zWcNoKUYxIcSfW6oGyM/VM2WA6qiv9T+kvR8MINhMrzZlZndiw9vcUErK
         X4XDzmS0kKvTA==
Date:   Sat, 27 May 2023 11:30:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ansuelsmth@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: document
 IPQ8074
Message-ID: <20230527-pang-barracuda-7e39f866e1bd@spud>
References: <20230527095229.12019-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TtabgKqrDUwQ41pc"
Content-Disposition: inline
In-Reply-To: <20230527095229.12019-1-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TtabgKqrDUwQ41pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 11:52:28AM +0200, Robert Marko wrote:
> Document IPQ8074 compatible for Qcom NVMEM CPUFreq driver.
>=20
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--TtabgKqrDUwQ41pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHHb1wAKCRB4tDGHoIJi
0plzAQDcarveDiMqi90WOejJruf/w6o7PF6WTg4AudIrTNk7cgEA7GKxK5yV4tWe
28S6Tk6lJFfTonXKEUSYx1sJoR+UKAg=
=nZWe
-----END PGP SIGNATURE-----

--TtabgKqrDUwQ41pc--
