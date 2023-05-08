Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC806FA4A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjEHKBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjEHKB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:01:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65FD2E062;
        Mon,  8 May 2023 03:01:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6439f186366so2134071b3a.2;
        Mon, 08 May 2023 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683540086; x=1686132086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJvJGURrh5Y6Ahv+dvSHYL3+bNVZ9g/h4mq9+B66qRI=;
        b=IPShIZ0hYGoGQZ+QpgYEoS7sXMWJihKWBFY8s06PyRBEPpO8fiac9zfXtKK+oC+7ks
         +5JM8r+DcylJmbKZJjo1jkOrh4NpjgM1KMT/6PXtTdt7P16Q1bVpoOQMJu/xd6ZuQJf6
         g0wxdJshfIpodgZPz8OSPuNG8QEfupLy5h2HhTz9rjIDjUPXK1rVQ7aazGvB5W8WfNld
         JhRCRS6vM7Dl2sn+luKAPSacYOwUCV6Uu/hstIDQaxTcuZKxGKGwqUbCRdEAR5dMajWV
         PZF1Vy+nsY72Pl4fdXRbabdzVh6jYSVvgiKnDr3yLcl7t0C5+d/Vc6M+qwI1gNWSsMZR
         CAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683540086; x=1686132086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJvJGURrh5Y6Ahv+dvSHYL3+bNVZ9g/h4mq9+B66qRI=;
        b=FekkjWtelKJd+P4Mb9vrpEIxVnk2esoGx4LDivqTRewf1hOFKzkFKeGmrndua9se27
         aC7+PAfVsjgIxqUrbro5F55kMgCieEtkAjOoED7gzPCMFV+UVawB4wJMaO1ZuavCW/Gk
         UgGQlXuQ3gtdcOxnRZ/SzB07nlsskCJXlg77TC28U+oHIVzk5n1inCiCMjFdUNogqc7j
         7ZTmcgqgJ9HDAN9qokuI/O5PgYBX6agI4CKZX3Osicx22lAkqOb/kq5gYlySqkZzMRh1
         oVBTBFrY4T5dId0tiSJN6zgYh/7Wc7Pz0i56/LVZFOxQTG6wb+hzGiTJmCNEOZ/BJ9Ps
         s1Lw==
X-Gm-Message-State: AC+VfDzasEe6x5Gz24fMbjKYHa6wHogSVsCL+46dlYwyTwIpHmpb9Y7t
        ZX8a+7Bj+NjlLikJYPreKHk=
X-Google-Smtp-Source: ACHHUZ432kkuqfkRj7AzZft5/WbhfjXcUv0u9eGieSBZ3qtznBd/fiH77+wHRKFcmjTGSgYOzAr1dw==
X-Received: by 2002:a05:6a00:1694:b0:63b:57cb:145f with SMTP id k20-20020a056a00169400b0063b57cb145fmr13083641pfc.20.1683540085842;
        Mon, 08 May 2023 03:01:25 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-55.three.co.id. [116.206.28.55])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b0062d90f36d16sm2667483pfo.88.2023.05.08.03.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:01:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0C36010687E; Mon,  8 May 2023 17:01:21 +0700 (WIB)
Date:   Mon, 8 May 2023 17:01:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 03/18] docs: qcom: Add qualcomm minidump guide
Message-ID: <ZFjIcSRSitmOvmZw@debian.me>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-4-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y9mITgkKFRXba6ks"
Content-Disposition: inline
In-Reply-To: <1683133352-10046-4-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y9mITgkKFRXba6ks
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2023 at 10:32:17PM +0530, Mukesh Ojha wrote:
>  Documentation/admin-guide/qcom_minidump.rst | 246 ++++++++++++++++++++++=
++++++
>  1 file changed, 246 insertions(+)

You forget to add toctree entry:

---- >8 ----
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guid=
e/index.rst
index 43ea35613dfcd4..251d070486c2ab 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -120,6 +120,7 @@ configure specific aspects of kernel behavior to your l=
iking.
    perf-security
    pm/index
    pnp
+   qcom_minidump
    rapidio
    ras
    rtc

> +Writing to sysfs node can also be used to set the mode to minidump.
> +
> +::
> +	echo "mini" > /sys/module/qcom_scm/parameter/download_mode

The snippet above isn't rendered to code block, so I have to fix it up:

---- >8 ----
diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/ad=
min-guide/qcom_minidump.rst
index 062c797e90d9cf..408fe1beed1b78 100644
--- a/Documentation/admin-guide/qcom_minidump.rst
+++ b/Documentation/admin-guide/qcom_minidump.rst
@@ -208,9 +208,8 @@ Similarly, "full" is passed to set the download mode to=
 full dump
 where entire ddr dump will be collected while setting it "full,mini"
 will collect minidump along with fulldump.
=20
-Writing to sysfs node can also be used to set the mode to minidump.
+Writing to sysfs node can also be used to set the mode to minidump::
=20
-::
 	echo "mini" > /sys/module/qcom_scm/parameter/download_mode
=20
 Once the download mode is set, any kind of crash will make the device coll=
ect

> +By default, dumps are downloaded via USB to the attached x86_64 machine
> +running PCAT (Qualcomm tool) software. Upon download, we will see
> +a set of binary blobs starts with name md_* in PCAT configured directory
> +in x86_64 machine, so for above example from the client it will be
> +md_REGION_A.BIN. This binary blob depends on region content to determine
> +whether it needs external parser support to get the content of the regio=
n,
> +so for simple plain ASCII text we don't need any parsing and the content
> +can be seen just opening the binary file.
> +
> <snipped> ...
> +One need to read the entire rawdump partition and pull out content to
> +save it onto the attached x86_64 machine over USB. Later, this rawdump
> +can be pass it to another tool dexter.exe(Qualcomm tool) which converts
> +this into the similar binary blobs which we have got it when download ty=
pe
> +was set to USB i.e a set of registered region as blobs and their name
> +starts with md_*.
> +
> +Replacing the dexter.exe with some open source tool can be added as futu=
re
> +scope of this document.

There is inconsistency on inlining code keywords, so I have to inline
the rest:

---- >8 ----
diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/ad=
min-guide/qcom_minidump.rst
index 408fe1beed1b78..117e61ef9fde67 100644
--- a/Documentation/admin-guide/qcom_minidump.rst
+++ b/Documentation/admin-guide/qcom_minidump.rst
@@ -118,7 +118,7 @@ Client driver can use ``qcom_apss_minidump_region_regis=
ter`` API's to
 register and ``qcom_apss_minidump_region_unregister`` to unregister
 their region from minidump driver.
=20
-Client need to fill their region by filling qcom_apss_minidump_region
+Client need to fill their region by filling ``qcom_apss_minidump_region``
 structure object which consist of the region name, region's
 virtual and physical address and its size.
=20
@@ -166,7 +166,7 @@ Test
=20
 Existing Qualcomm devices already supports entire ddr dump (also called
 full dump) by writing appropriate value to Qualcomm's top control and
-status register(tcsr) in driver/firmware/qcom_scm.c .
+status register(tcsr) in ``driver/firmware/qcom_scm.c``.
=20
 SCM device Tree bindings required to support download mode
 For example (sm8450) ::
@@ -202,10 +202,10 @@ For example (sm8450) ::
=20
 	};
=20
-User of minidump can pass qcom_scm.download_mode=3D"mini" to kernel
+User of minidump can pass ``qcom_scm.download_mode=3D"mini"`` to kernel
 commandline to set the current download mode to minidump.
-Similarly, "full" is passed to set the download mode to full dump
-where entire ddr dump will be collected while setting it "full,mini"
+Similarly, ``"full"`` is passed to set the download mode to full dump
+where entire ddr dump will be collected while setting it ``"full,mini"``
 will collect minidump along with fulldump.
=20
 Writing to sysfs node can also be used to set the mode to minidump::
@@ -223,9 +223,9 @@ stored to an attached storage device.
=20
 By default, dumps are downloaded via USB to the attached x86_64 machine
 running PCAT (Qualcomm tool) software. Upon download, we will see
-a set of binary blobs starts with name md_* in PCAT configured directory
+a set of binary blobs starts with name ``md_*`` in PCAT configured directo=
ry
 in x86_64 machine, so for above example from the client it will be
-md_REGION_A.BIN. This binary blob depends on region content to determine
+``md_REGION_A.BIN``. This binary blob depends on region content to determi=
ne
 whether it needs external parser support to get the content of the region,
 so for simple plain ASCII text we don't need any parsing and the content
 can be seen just opening the binary file.
@@ -236,10 +236,10 @@ partition on the target device itself.
=20
 One need to read the entire rawdump partition and pull out content to
 save it onto the attached x86_64 machine over USB. Later, this rawdump
-can be pass it to another tool dexter.exe(Qualcomm tool) which converts
+can be pass it to another tool (``dexter.exe`` [Qualcomm tool]) which conv=
erts
 this into the similar binary blobs which we have got it when download type
 was set to USB i.e a set of registered region as blobs and their name
-starts with md_*.
+starts with ``md_*``.
=20
-Replacing the dexter.exe with some open source tool can be added as future
+Replacing the ``dexter.exe`` with some open source tool can be added as fu=
ture
 scope of this document.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--y9mITgkKFRXba6ks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFjIbAAKCRD2uYlJVVFO
oyXUAP9Jdvp3ekfNs/R/xT6oObGE6Yey/Lz3Tnr82n5uZ2grhgD+Jc+IKZQhm8/Q
linikE60BwEYt7d/w1AiQuaOIvuahgk=
=PaTP
-----END PGP SIGNATURE-----

--y9mITgkKFRXba6ks--
