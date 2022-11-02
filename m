Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26FA6162C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKBMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiKBMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:35:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954062936E;
        Wed,  2 Nov 2022 05:35:08 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b62so5742993pgc.0;
        Wed, 02 Nov 2022 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytob8zx1SKLrpfmFHLBokxWlh3AKyd6aWp40MhHR3AA=;
        b=L+WGEPxtjHZGG+0/03qhtcLzwTWa0RZvC6ENbtnYYEmGdOdqzORyCYWGHiiKGwBbZp
         KslMkod7TDhB8M0NXP2k/nLbt9OCY3e+3cdkqW9y+YimCUIenhZoL3a6OXgPowGILUxX
         gRjl7Jb0Ux1nGP34bMqyiSWOkaugy4IC1/m8vql7oRWtS/IoOeOQatQafP+Pg96OhfSn
         Q7fv7twRUQVxEMmym8IOEfYsAnBx/udNvUVEpKWpif7oh5++Jt6I+7+7RvHE3v+F3O3v
         lSCqoLRINb8GEybY6rkPROmwAkKFlBNnIaYSLWx0tZAYhd/+7HZJfiiX2URPxsihLRxE
         3PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytob8zx1SKLrpfmFHLBokxWlh3AKyd6aWp40MhHR3AA=;
        b=tZ8WDbgXfytWV8O1xzh4ttT03dkghL2vofQteC3l6PKETnJVBsSgI62ia3cWcKqdot
         z653DJx3NTvRV7VsEWQA/2zhAdDW3ZiBD/T/pZum7knvAxqULno57rOo3sXQUJAHJqyX
         z3NxwzlJShsIVT7RmbZTHXdWvDagIt2R2FtkofPGU/f3OhQxLkbOWqt3fwcryhN3PVkS
         3X0OJzuz2aWPZ5HyFaDbssX6hU1TkT9qo99hJfHNVAQgIL0gaPw1vC8f1S5D4rG/xWTj
         zAVwmuTYsf1X6hbOCbvnOdmseJltPW2v2XsRhyqrJCSfyz9wzZoRYAxtZPJlXCMcHTMp
         CZSA==
X-Gm-Message-State: ACrzQf0IjXHkHF3U644wzGI/o+xyq1B3DVZDQzvcONTKgEHQJMZNXH58
        U19V5uUPjakY5kleW0DzzxA=
X-Google-Smtp-Source: AMsMyM4jOx9/ITQnqPBGYtd6ydBNmq2RMw1l33fg34hHBYM3Z1Lk8t/v3pEbA7l6diIXB1ayvFtrbw==
X-Received: by 2002:a05:6a00:1a8f:b0:56d:f7c2:959 with SMTP id e15-20020a056a001a8f00b0056df7c20959mr4269897pfv.71.1667392508049;
        Wed, 02 Nov 2022 05:35:08 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-50.three.co.id. [116.206.28.50])
        by smtp.gmail.com with ESMTPSA id m20-20020a6562d4000000b00462ae17a1c4sm7529521pgv.33.2022.11.02.05.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:35:07 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 01518103835; Wed,  2 Nov 2022 19:35:04 +0700 (WIB)
Date:   Wed, 2 Nov 2022 19:35:04 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/21] docs: gunyah: Introduce Gunyah Hypervisor
Message-ID: <Y2Jj+FLcL8pYLv+q@debian.me>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-2-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lcWsjmNz5hWimLOD"
Content-Disposition: inline
In-Reply-To: <20221026185846.3983888-2-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lcWsjmNz5hWimLOD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2022 at 11:58:26AM -0700, Elliot Berman wrote:
> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
> does not depend on any lower-privileged OS/kernel code for its core
> functionality. This increases its security and can support a smaller
> trusted computing based when compared to Type-2 hypervisors.
>=20
> Add documentation describing the Gunyah hypervisor and the main
> components of the Gunyah hypervisor which are of interest to Linux
> virtualization development.
>=20

LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--lcWsjmNz5hWimLOD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2Jj9QAKCRD2uYlJVVFO
o8iZAP9ne1/t0CSHYZJHKuMWjnNVF9v2tjatTGFij3brCK5ccgEA6ZehG9xndGC0
Ga0PcJr9HBhqMNopmGgdNKin3IzhMAs=
=VAEi
-----END PGP SIGNATURE-----

--lcWsjmNz5hWimLOD--
