Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C04709CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjESQtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjESQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB5EC;
        Fri, 19 May 2023 09:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 277B86594E;
        Fri, 19 May 2023 16:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EFEC433D2;
        Fri, 19 May 2023 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684514906;
        bh=8Gl6iYH6gR/9z8MMwXI7I7Ruzm5hvUrJgueITf+FkeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCskzqen57JjtATBDsrIKARbpRgKBmGJluamvr+sroASrbC3ZsPXzBZu1lLHlLhHa
         N74o0KY9aziyUVcqaxkkZZrZpZEWfOLLdLL5p9qA9QDIMsxzeuLBcT0kt1YuAmIme2
         wEPAgmUEokI4xnXpSjdeXrsnypuPsKDlLI9i29R3ewCt12LLQzoR22h60MXff+hP2k
         pgARHOFQo5jq0D8e+MVj2+lArp+3PBAKmkV8VPRlcshdv112s8vyUe9wpezor3wibZ
         fKtY7znpaSD2gezUKOPH/aFmfPBwIpCrsnPMcPfPJZaCwcXp80hxeGiQn0FW+4hEW7
         f/I9Fay7oxoPQ==
Date:   Fri, 19 May 2023 17:48:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: Re: [PATCH 2/4] dt-bindings: clock: qcom: Add SM8550 camera clock
 controller
Message-ID: <20230519-crumb-vividly-0d278146defe@spud>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
 <20230519155602.6642-3-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0XkQP2uuk2uCUtkF"
Content-Disposition: inline
In-Reply-To: <20230519155602.6642-3-quic_jkona@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0XkQP2uuk2uCUtkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 09:26:00PM +0530, Jagadeesh Kona wrote:
> Add device tree bindings for the camera clock controller on
> Qualcomm SM8550 platform.
>=20
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>

Should this SoB go with a Co-developed-by?
I'll leave it up to Krzysztof or someone else familiar with qcom
products as to whether there's an existing binding that this should be
added to, but qcom,videocc.yaml seems "suspect" to an outsider.

Otherwise, what you have here looks fine to me.

Thanks,
Conor.

--0XkQP2uuk2uCUtkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGeoVQAKCRB4tDGHoIJi
0hjVAQCc+Zare9tPldClToejv4lzAIMi/YKvhKVIbgx55/zTKAD+O+V2sWV1RBr8
iJWNg8CL/rE8DM7bKclm10Sr6DsSnwY=
=xC/S
-----END PGP SIGNATURE-----

--0XkQP2uuk2uCUtkF--
