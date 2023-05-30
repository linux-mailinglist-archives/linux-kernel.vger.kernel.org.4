Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE77162E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjE3OCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjE3OCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:02:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53688B2;
        Tue, 30 May 2023 07:02:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97BB562A8E;
        Tue, 30 May 2023 14:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90A4C433D2;
        Tue, 30 May 2023 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685455361;
        bh=P/CJl+TCUUspElRvXCVnvQTrUt30ZK8wcFvJaqsz8uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuYHnuKKytbeuL0m2JIk9325ztxCtHp9nyCh7OWnPsflc0rYKgabOUY2fqqDvGAdV
         uB9CnTrEAciKQX4/KdxNIgzIvwYdvbDpAe4HW61CZh+JZ/Qm2r3et5rWNRNxZEoLbN
         N31NUxUWw3yL8A59lJt8eXz14AH6vVmPtnKNmNeLC8RgYgFzuhvuJSkcCBMHsy4IeM
         Leg6+8PeNpPyiKoGWaOMDV13konMq2ifbgq+4abZLt3CBQvs9cduiKHbNDbJLmHzlF
         UZCUhtgOwlouvK/GNQydGVSjMmNQbGb3JEmnLAsK5Za87DzEW/7tOgyNp22jLhr6Ua
         el/ZKbAu3qU7Q==
Date:   Tue, 30 May 2023 15:02:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: Breaking change in st1232 multitouch support
Message-ID: <cace0a0b-76bf-4a99-835b-911fb9831453@sirena.org.uk>
References: <b1ef61f5121149278b66d4cea99ba02b517fb0c9.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4Hc0J3TgO+/7Y0W"
Content-Disposition: inline
In-Reply-To: <b1ef61f5121149278b66d4cea99ba02b517fb0c9.camel@ew.tq-group.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4Hc0J3TgO+/7Y0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2023 at 03:59:34PM +0200, Matthias Schiffer wrote:

> Adding Mark Brown to cc as a somewhat recent committer to a DTS that
> references the "sitronix,st1232" compatible (imx6qdl-udoo), in the hope
> that he has a matching display and could verify that multitouch is
> indeed broken with recent kernels.

It's sitting in a CI farm and I never physically interact with it - I
think the display is an optional extra which I don't have anyway.

--p4Hc0J3TgO+/7Y0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR2AecACgkQJNaLcl1U
h9Aq2Af/Z0aTgtOOd+N7bsD+3QyNPma7/g5IVDMNvuCBtbfFSfx8PSIkhUx4WA7W
aOu2ZqYtZwUpbi6zgOcrqu+GYDTcmP5cIDbBpPlKOtSGXi8ChpGNQDriiWx/Auxq
NshLyhl6dQY888uwffpY1bMsAl7YM5eGqosVXdxBLI61jK/n3ywvO0hESP81a8EH
gaBWywdNhk4PsVdLv66pGI3RW55hH54KlMDg+IvijdiumtgTQThnSW9lGJIgdM14
bc1AtJxGf9EJrVsKnip8J/oDA6u8sHN7oCFEiNG/fGVtQG6LZWaCSxKqSbpUjo7A
qa2RaAKVdST7VoVDSoZdid5f/YcFqQ==
=a0Yv
-----END PGP SIGNATURE-----

--p4Hc0J3TgO+/7Y0W--
