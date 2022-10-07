Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50A5F74D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJGHqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJGHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:46:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B7DED07;
        Fri,  7 Oct 2022 00:46:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bs18so4790223ljb.1;
        Fri, 07 Oct 2022 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44mpfHoFiwx2iyX6E3gH6EceYy6f5JbWrB04sIP1c+o=;
        b=Iaj+Y/jJ74tsjfnMKOyVFppae9gzHCsmcdvFtNM6sBL1cKF5YSuopcCEohMxQaeROb
         heR5yZzhxPdJXFjO8sXCFeGJJReIc8ApAKeUwlL3FnCSYPyMq9ABEWfcC/YFcZiGuAx/
         /S6XUNaE4NNIXTrIhQ4+gw9pztJ2WieWIOThAr6smKXcHHHLZMMuA627c27NhySiwVXC
         bms4TBSHvswkruAtZT31isTOaIeObVHexq7cWpWcFxiQ9lWrnWmvXHxawsK0KYHbXLL1
         h8f6tvO4FatsgTzXJtSfwhWnAONBEG1yi7Zb10PQxjbvbEzYvVqwDhePBJDSYRF/UD2S
         zi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44mpfHoFiwx2iyX6E3gH6EceYy6f5JbWrB04sIP1c+o=;
        b=j8kFC9eYQ4yMTpSjoSqfMe2xDKkkyiXPPfVpTJyXrrUxRoaQRI5fPSwtoXV4qeAdL1
         1lhdMU64bmzQasH+oQdbyCnzLoXN2jqkSLxJsNqn7kaj3b+fiQ9YWkRDAlGmn99jomQh
         RHzI0Jn/s9FfnSlFPxatA7JgZekUP4AiEJOBnK1tgkw8mRptAeG0YFho2NQr9IOiHRLc
         qlsyP8J2bgT0DsgaR0/1gJKX35o2L54VOlCa7pkxAxlZqbBwS6R5UoHr4tV/tTtJNUPB
         NnYiEotiJ2uQGS4Ndk/yGp7bhRTpV3VUQdvt0ae5jpKKogbL8OaiaOJvZ7XU560+HX9j
         7DcQ==
X-Gm-Message-State: ACrzQf2IpVyLSrqv46EtfhrJdEkgJeiYcFI6o9/zwhUTb0K9h9A8fx8f
        RWI+Nt/jDnzDX0hLrppIgzs=
X-Google-Smtp-Source: AMsMyM739/J//45IHCpcc2Agu2xbk8hjLIJf5h+N9kUdmtTruQgwwrJFLSwBXDDspzGU6CJ9COmptg==
X-Received: by 2002:a2e:995a:0:b0:26e:3cdf:f80e with SMTP id r26-20020a2e995a000000b0026e3cdff80emr527743ljj.144.1665128761282;
        Fri, 07 Oct 2022 00:46:01 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b0049ad2619becsm190554lfk.131.2022.10.07.00.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 00:46:00 -0700 (PDT)
Date:   Fri, 7 Oct 2022 09:45:59 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: hid-alps: use default remove for hid device
Message-ID: <Yz/ZNzVFoh4zO9sW@gmail.com>
References: <20220915123438.520775-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FlZxSfG4OPWffxjo"
Content-Disposition: inline
In-Reply-To: <20220915123438.520775-1-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FlZxSfG4OPWffxjo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 15, 2022 at 02:34:38PM +0200, Marcus Folkesson wrote:
> hid_device_remove() will call hid_hw_stop() as default .remove function
> if no function is specified.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Ping

Best regards,
Marcus Folkesson

--FlZxSfG4OPWffxjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmM/2TIACgkQiIBOb1ld
UjKeSRAAoIn7S2BxCGn52zwbzDzoT8D0BDSN+7Azb7xdFh5s3Wo9aldyYabWkCKM
7ImIrqoDP0v4L5rIbJggRQUUDFgiPIrh+KveYgDhDodzECwagdmZwuFzSxhQwSac
cXCgCJSnGIRMNanNiXOL94ek/u59mkH6Q3oLORlo6YUCDolwRE8XxiOVHjRs9+cO
7Y1ckSAk+RPCwKS1Cs2fgLAYjXtJ/MSs+vW+CVjygO5sGY7l0HWHncPfwZCeqpOg
76r2iujMXPrBetnvg6TfsPwez/cK+OB+B9e/gOerTU4nlSKZCFtKKH7WBHx+5+H6
OEQ6a9cRgk2neEIJr3UYpxNLDIHyHFtCKIfq9/vedigqkJHnPENbOvWngnOsFNl0
n3znYXuStjZvqSHZ9wgGVRGXewiVClQNynr6+gtc4soiS0Gaa1oUTZY+sPEguiaP
W9na5OkOtj26TVSakTEDVXULXKFXdgY4y+N6j1liitg7eFK7wQrJ6qhZHuITitim
6cEQuRLP8BfcuWIG8XCYaG5yjfGelfJOUeQxq9IlC2312PY4thKf95zjXPDZhpix
a7zZF/2WLubgSL8xpX85bCZRhw5O5eIYr4x9b2Vy87YZGxKBcN1RxyO8Pq+Rsk2g
k7d0PkvO3i480vnPLBgKkg63M7hcC4VBJZsb3QUqNHc5rITN88I=
=RddR
-----END PGP SIGNATURE-----

--FlZxSfG4OPWffxjo--
