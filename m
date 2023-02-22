Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A1B69FF1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjBVXB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjBVXBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:01:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04035410AE;
        Wed, 22 Feb 2023 15:01:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3C46B818D1;
        Wed, 22 Feb 2023 23:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3A3C433D2;
        Wed, 22 Feb 2023 23:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677106879;
        bh=5Epr+Sg2dMQsZpAgQsCxMuhd2oNEoAwQFrpqJFEYeHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MY985pim1F7QnE9UtW2aav5FRQV7YnpLQsq1byMYrO5o6NAx1vVPl1Bo7sVO3FkV2
         gVUP681jbVZ1WGmp30SyrUMAFeyU4ZJ0zs1cTe8ROURO7erdAsgxNcEjTlB1dTfY5Y
         sAX2oIWZcPXg9tpHOiY9K8gqg5C6YhSKBcd+FGTO4rodVCrVzU6arm6k6mrSfw6bWs
         4FFSp9tCi1PIvmCjfS5+hIGOF+Xagwy9qCjy9oHKls/H3GjftrmikVfgiwPna/rSd1
         aWO97sSRj1goxAGWjdVPjokhM92/S7+/HzNSmE6U1OUkPY7SaRSEBenf/DkOyR8q1t
         6+DYDMaMbJl4g==
Date:   Wed, 22 Feb 2023 23:01:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
Message-ID: <Y/aeu5ua7cY5cGON@sirena.org.uk>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-5-quic_devipriy@quicinc.com>
 <907628d1-b88d-5ac6-ed9d-7f63e2875738@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dRZIuVS8T/5W7hxa"
Content-Disposition: inline
In-Reply-To: <907628d1-b88d-5ac6-ed9d-7f63e2875738@linaro.org>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dRZIuVS8T/5W7hxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:

> Thinking about it again, this seems like something that could be
> generalized and introduced into regulator core.. Hardcoding this
> will not end well.. Not to mention it'll affect all mp5496-using
> boards that are already upstream.

> WDYT about regulator-init-microvolts Mark?

The overwhelming majority of devices that have variable voltages
support readback, these Qualcomm firmware devices are pretty much
unique in this regard.  We don't want a general property to set a
specific voltage since normally we should be using the
constraints and don't normally need to adjust things immediately
since we can tell what the current voltage is.=20

This is pretty much just going to be a device specific bodge,
ideally something that does know what the voltage is would be
able to tell us at runtime but if that's not possible then
there's no good options.  If the initial voltage might vary based
on board then a device specific DT property might be less
terrible, if it's determined by the regulator the current code
seems fine.  Or just leave the current behavour, if the
constraints are accurate then hopefully a temporary dip in
voltage is just inelegant rather than an issue.  Indeed the
current behaviour might well save power if you've got a voltage
range configured and nothing actually ever gets round to setting
the voltage (which is depressingly common, people seem keen on
setting voltage ranges even when the voltage is never varied in
practice).

--dRZIuVS8T/5W7hxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2nrsACgkQJNaLcl1U
h9BSYAgAg7R+LoNCsEJBpg9GBF0QWNVI+uDSXvbYm2PlkJChzl7FRWdyOCaRBrA4
xXb6lqs5PxU3aNBvpIFeSxfsLgb1zvjLPA+xSIUVvn/nYrijd58CgU9mp3+iCyzs
2+O+WPJZuZaNcc3FzS6t9PxPVRg0uYby6H0BJ6ZdRe0GgNhznx2tq1M+Em517w90
u8eiSfdQEfbE0woSFIGTH+scvTmWJAfcMRU3m1nEJcjd2PBL/TX7P4QciGEsGT66
wAPeb8uGUKWDTqZsJNN2i3/S5q/TRRfTo7piotQVrJPS6nnJvAQL17mz3NjAf9bP
7Ig1FRDtI4GJOBiBkwOwOMnlX25AMw==
=zYTX
-----END PGP SIGNATURE-----

--dRZIuVS8T/5W7hxa--
