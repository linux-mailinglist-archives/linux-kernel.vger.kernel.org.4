Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3656C9EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjC0JHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjC0JHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:07:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA54EFD;
        Mon, 27 Mar 2023 02:06:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7so7048117pjg.5;
        Mon, 27 Mar 2023 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679907993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8fUt4pO+XHuFO5xT5Dt4jN0bSb0IjaRl69C7+BMdDg=;
        b=LcgNg+6NtV1SL1HZQ41SfLf4+zxLtfV9YXrxPK7vJ5t3NhP4X/JdG0vszd1eEYhVEi
         Lx0vA1NU1gcwAQ8PRLarirt1b17dx3ulnzdHVH3i9FyW/z845IxGIo4PEVkQAxINU0kz
         O2BbcKQHUzwTxWoIs4Nl9/n8vmpmDFssbVjkJtANNenJpDzQQM3coQDZhgRLEqCACobQ
         NA26ZrjjI4CcToPS5twfuS0xEWwLRWevqsCZH/kaaBMSyPDAgQYA+YrSDAEcICpyyYH/
         KiS0tgcgHQbHeXuzAIOXjLgCE46vLsxSFJunPzgAq2e+Lc8OPBQ5cmJX9U/Y8FcU9ki2
         CzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679907993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8fUt4pO+XHuFO5xT5Dt4jN0bSb0IjaRl69C7+BMdDg=;
        b=1UyTcrX+UqTns8O0csW/dsL36bsNxwbNH430svLFoKY69i807b8w6lSynSlIUFTiN+
         3I84cX9b6b6y5fMWLAZtzxCgJ0QDVj13p7tp8f0v+8+X2tc6t8FZlnlO4dvJlj9gNnVG
         Dl4Wu3ErUyhVLSkdWByxy8Yjd1ZbkAXa1YgeHafARJvRSTPaa3MUSaqnnMZ6cAeFF+0n
         o9vLY1f1KNHXdJeyHJqntpi42bqoJhyfEEKPYVyMfsoTX0y5AC9Qbek2KcWJqm5jCq3G
         tySBy/3fj/XP9BmzUs7ytdDL+2k0EvN7QAHEq6nfxijdMsWZpBFKXyM6hzwIttkWmOP4
         jdyQ==
X-Gm-Message-State: AAQBX9dEAFC8U4fD6vR3M4AXh56/vCNMNtydlwxHSaIC3Jj/rCdVq67f
        klY3vMyFRFDpK6Ic2QOETP0=
X-Google-Smtp-Source: AKy350akZsC9DAW9cAZ9dO/WH1qyoqAa+nZML0KGvlXEjleks2KmWYsZflCCbNjDE2Oyna1h5ZRy6w==
X-Received: by 2002:a17:903:28c8:b0:1a2:19c1:a974 with SMTP id kv8-20020a17090328c800b001a219c1a974mr8678082plb.68.1679907993332;
        Mon, 27 Mar 2023 02:06:33 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b0019468fe44d3sm18629240plk.25.2023.03.27.02.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 02:06:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6B322106758; Mon, 27 Mar 2023 16:06:29 +0700 (WIB)
Date:   Mon, 27 Mar 2023 16:06:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Documentation: trace: Add documentation for
 Coresight Dummy Trace
Message-ID: <ZCFclDU2JZLzbVX/@debian.me>
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-4-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nhj3/4xBxIE5HRwH"
Content-Disposition: inline
In-Reply-To: <20230324061608.33609-4-quic_hazha@quicinc.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nhj3/4xBxIE5HRwH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 02:16:08PM +0800, Hao Zhang wrote:
> +Sysfs files and directories
> +---------------------------
> +
> +Root: ``/sys/bus/coresight/devices/dummy<N>``
> +
> +----
> +
> +:File:            ``enable_source`` (RW)
> +:Notes:
> +    - > 0 : enable the datasets of dummy source.
> +
> +    - =3D 0 : disable the datasets of dummy source.
> +
> +:Syntax:
> +    ``echo 1 > enable_source``
> +
> +----
> +
> +:File:            ``enable_sink`` (RW)
> +:Notes:
> +    - > 0 : enable the datasets of dummy sink.
> +
> +    - =3D 0 : disable the datasets of dummy sink.
> +
> +:Syntax:
> +    ``echo 1 > enable_sink``

Is enable_{source,sink} integer-valued or bit (0/1)? In other words, is
it OK to `echo 2` to both sysfs files?

> +
> +----
> +
> +Config details
> +---------------------------
> +
> +There are two types of nodes, dummy sink and dummy source. The nodes
> +should be observed at the coresight path
> +"/sys/bus/coresight/devices".

For consistency, inline this sysfs also (thus
``/sys/bus/coresight/devices``.

> +e.g.
e.g.:: (make the shell snippet below code block)
> +/sys/bus/coresight/devices # ls -l | grep dummy
IMO I prefer `PS1=3D\$` (that is, omit the directory). Alternatively,
you can write `ls -l /sys/bus/coresight/devices | grep dummy` (specify
the directory to `ls`).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Nhj3/4xBxIE5HRwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCFcjwAKCRD2uYlJVVFO
o1gMAP9hA3XoJ+1BWv3KOewMhgRMYIwCugU1u1SLb6+ulgXKKQD8DNcMJrpatOcs
cyouf4vyhI6HmCRIK5V0aHosRUkHrQM=
=Bs3E
-----END PGP SIGNATURE-----

--Nhj3/4xBxIE5HRwH--
