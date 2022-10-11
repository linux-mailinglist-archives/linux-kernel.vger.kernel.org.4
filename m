Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8B15FAEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJKJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKJGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:06:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB5A13CD6;
        Tue, 11 Oct 2022 02:06:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so12335018pgb.4;
        Tue, 11 Oct 2022 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=joIwYkCaZzwkJliIHeWwNwZoSSGOJWmxAZOUiLTxI64=;
        b=WrYTvU3ZNsNHDL4CgKzkM2oUIyJbaVhjEiQQSwOnvQkE2GHtvhIbN4W0wQm0O9o0GP
         yDqCf67V9opqgI2ebIWMYfOyGn5ijfGJkh/xbdNnbRGDM5vtmSQFA3cnkVTuanllmpaN
         TXj6rU+k1WR8tu5/mQUB0cgNlamZDfh0hP4W3kNbxSF7b7X4xqQoeE6n6aU2MveiPNUH
         ztOKs87Z+R5pY4lXk7CVY89sgIiT6dsWcJuxZwN8Z6RFFPuNDDhCyL1sQ582Nx4Tvj+q
         U20VW6y9YbC9oaYVrT0RGtHXra8FVpKCVQgg/lO3zYjhfzfdocNC6+jQm5LnsddriSn0
         3r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joIwYkCaZzwkJliIHeWwNwZoSSGOJWmxAZOUiLTxI64=;
        b=AWE94OUsYtSJ+sbZg52lVL4pp7VYmBs4nWBUYp1c7jJCkXIbS5OPJti4kM7TdcQ+5I
         aqRbg3YZJ2Z6iJs/q4/rjHSXt4N3NgCFBet1A/wgfyg1Pr6hNkP2q23e3e0CXCFGIDsf
         pWXuexw9lJvOJzeBYOlaLN6FMaLOOZBoggPK1Ce8WcWFz6I3sVOqtuUWBX34iNtPc04h
         CyAEV09sx9Nt4TQgVDYyRPim/oNxJAOLEHwK+CUiwI/Q2NuiouyWJvaXblJI3lenCbTV
         MZdXgiTb9k00MDk8oz6eyJ1i/n8mxkZQIWbEFMZrBMCdNUm0iLFZ4oGkTEt3xI7cSZg4
         KcCA==
X-Gm-Message-State: ACrzQf1Sjgf6IulmlfaStPhpPA8q2Adtx3fOi4s3H/fNox7kM/mLYtvY
        9did0mPrTQN2e54stoQ4bSLAHbsOnmvnKw==
X-Google-Smtp-Source: AMsMyM7LD7KCZwRLVVv1Z9wIW0LMITloIIQFtyhyfz5LY7vnAj2FsmJiFC4yaAeuTzeRwSDtzHmCrA==
X-Received: by 2002:aa7:88d6:0:b0:563:9fe9:5da8 with SMTP id k22-20020aa788d6000000b005639fe95da8mr4544943pff.74.1665479193386;
        Tue, 11 Oct 2022 02:06:33 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id f5-20020a635105000000b00456891e1dacsm7392193pgb.68.2022.10.11.02.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 02:06:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BCCDD10381D; Tue, 11 Oct 2022 16:06:29 +0700 (WIB)
Date:   Tue, 11 Oct 2022 16:06:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v6 12/12] Documentation/x86: Update resctrl_ui.rst for
 new features
Message-ID: <Y0UyFRJNjqBzCX8Z@debian.me>
References: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
 <166543384024.23830.1715326237069935949.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1jn1q8Ke7yaH7q25"
Content-Disposition: inline
In-Reply-To: <166543384024.23830.1715326237069935949.stgit@bmoger-ubuntu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1jn1q8Ke7yaH7q25
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 03:30:40PM -0500, Babu Moger wrote:
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 71a531061e4e..e2a59249d183 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of=
 Service(AMD QoS).
>  This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/=
cpuinfo
>  flag bits:
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>  RDT (Resource Director Technology) Allocation	"rdt_a"
>  CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
>  CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
>  CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
>  MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
>  MBA (Memory Bandwidth Allocation)		"mba"
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +SMBA (Slow Memory Bandwidth Allocation)         "smba"
> +BMEC (Bandwidth Monitoring Event Configuration) "bmec"
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> =20
>  To use the feature mount the file system::
> =20
> @@ -161,6 +163,79 @@ with the following files:
>  "mon_features":
>  		Lists the monitoring events if
>  		monitoring is enabled for the resource.
> +                Example::
> +
> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                   llc_occupancy
> +                   mbm_total_bytes
> +                   mbm_local_bytes
> +
> +                If the system supports Bandwidth Monitoring Event
> +                Configuration (BMEC), then the bandwidth events will
> +                be configurable. The output will be::
> +
> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                   llc_occupancy
> +                   mbm_total_bytes
> +                   mbm_total_config
> +                   mbm_local_bytes
> +                   mbm_local_config
> +
> +"mbm_total_config", "mbm_local_config":
> +        These files contain the current event configuration for the even=
ts
> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
> +        Bandwidth Monitoring Event Configuration (BMEC) feature is suppo=
rted.
> +        The event configuration settings are domain specific and will af=
fect
> +        all the CPUs in the domain.
> +
> +        Following are the types of events supported:
> +
> +        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +        Bits    Description
> +        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +        6       Dirty Victims from the QOS domain to all types of memory
> +        5       Reads to slow memory in the non-local NUMA domain
> +        4       Reads to slow memory in the local NUMA domain
> +        3       Non-temporal writes to non-local NUMA domain
> +        2       Non-temporal writes to local NUMA domain
> +        1       Reads to memory in the non-local NUMA domain
> +        0       Reads to memory in the local NUMA domain
> +        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +        By default, the mbm_total_bytes configuration is set to 0x7f to =
count
> +        all the event types and the mbm_local_bytes configuration is set=
 to
> +        0x15 to count all the local memory events.
> +
> +        Examples:
> +
> +        * To view the current configuration::
> +          ::
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
> +            0=3D0x7f;1=3D0x7f;2=3D0x7f;3=3D0x7f
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
> +            0=3D0x15;1=3D0x15;3=3D0x15;4=3D0x15
> +
> +        * To change the mbm_total_bytes to count only reads on domain 0.
> +          To achieve this, the bits 0, 1, 4 and 5 needs to be set which =
is
> +          110011b (in hex 0x33).
> +          ::
> +
> +            # echo  "0=3D0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_c=
onfig
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
> +            0=3D0x33;1=3D0x7f;2=3D0x7f;3=3D0x7f
> +
> +        * To change the mbm_local_bytes to count all the slow memory rea=
ds
> +          on domain 1. To achieve this, the bits 4 and 5 needs to be set
> +          which is 110000b (in hex 0x30).
> +          ::
> +
> +            # echo  "1=3D0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_c=
onfig
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
> +            0=3D0x15;1=3D0x30;3=3D0x15;4=3D0x15
> =20
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
> @@ -464,6 +539,25 @@ Memory bandwidth domain is L3 cache.
> =20
>  	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...
> =20
> +Slow Memory bandwidth Allocation (SMBA)
> +-------------------------------------------------
> +AMD hardware can support slow Memory bandwidth Allocation feature.
> +Currently, CXL.memory is the only supported "slow" memory device.
> +With the support of SMBA feature the hardware enables bandwidth
> +allocation on the slow memory devices. If there are multiple slow
> +memory devices in the system, then the throttling logic groups all
> +the slow sources together and applies the limit on them as a whole.
> +
> +The presence of the SMBA feature(with CXL.memory) is independent
> +of whether slow memory device is actually present in the system.
> +If there is no slow memory in the system, then setting a SMBA limit
> +will have no impact on the performance of the system.
> +
> +Slow Memory bandwidth domain is L3 cache.
> +::
> +
> +	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...
> +
>  Reading/writing the schemata file
>  ---------------------------------
>  Reading the schemata file will show the state of all resources
> @@ -479,6 +573,44 @@ which you wish to change.  E.g.
>    L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff
>    L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff
> =20
> +Reading/writing the schemata file (on AMD systems)
> +--------------------------------------------------
> +Reading the schemata file will show the state of all resources
> +on all domains. When writing the memory bandwidth allocation you
> +only need to specify those values in an absolute number expressed
> +in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you
> +need to specify the value 16 (16 * 1/8 =3D 2). For example:
> +::
> +
> +  # cat schemata
> +    MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048
> +    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
> +
> +  # echo "MB:1=3D16" > schemata
> +  # cat schemata
> +    MB:0=3D2048;1=3D  16;2=3D2048;3=3D2048
> +    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
> +
> +Reading/writing the schemata file (on AMD systems) with SMBA feature
> +-------------------------------------------------------------------

The heading above produces htmldocs warnings:

Documentation/x86/resctrl.rst:595: WARNING: Title underline too short.

Reading/writing the schemata file (on AMD systems) with SMBA feature
-------------------------------------------------------------------
Documentation/x86/resctrl.rst:595: WARNING: Title underline too short.

Reading/writing the schemata file (on AMD systems) with SMBA feature
-------------------------------------------------------------------

I have applied the fixup:

---- >8 ----

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index e2a59249d18322..145916828f2bae 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -592,7 +592,7 @@ need to specify the value 16 (16 * 1/8 =3D 2). For exam=
ple:
     L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
=20
 Reading/writing the schemata file (on AMD systems) with SMBA feature
--------------------------------------------------------------------
+--------------------------------------------------------------------
 Reading the schemata file will show the state of all resources
 on all domains. When writing the memory bandwidth allocation you
 only need to specify those values in an absolute number expressed

> +Reading the schemata file will show the state of all resources
> +on all domains. When writing the memory bandwidth allocation you
> +only need to specify those values in an absolute number expressed
> +in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you
> +need to specify the value 64 (64 * 1/8 =3D 8).  E.g.
> +::
> +
> +  # cat schemata
> +    SMBA:0=3D2048;1=3D2048;2=3D2048;3=3D2048
> +      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048
> +      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
> +
> +  # echo "SMBA:1=3D64" > schemata
> +  # cat schemata
> +    SMBA:0=3D2048;1=3D  64;2=3D2048;3=3D2048
> +      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048
> +      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
> +
>  Cache Pseudo-Locking
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  CAT enables a user to specify the amount of cache space that an
>=20
>=20

The rest of prose can be improved:

---- >8 ----

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 145916828f2bae..92b2c4e03a4a26 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -217,9 +217,9 @@ with the following files:
             # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
             0=3D0x15;1=3D0x15;3=3D0x15;4=3D0x15
=20
-        * To change the mbm_total_bytes to count only reads on domain 0.
-          To achieve this, the bits 0, 1, 4 and 5 needs to be set which is
-          110011b (in hex 0x33).
+        * To change the mbm_total_bytes to count only reads on domain 0
+          (the bits 0, 1, 4 and 5 needs to be set, which means 110011b
+          {in hex 0x33}):
           ::
=20
             # echo  "0=3D0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_con=
fig
@@ -228,8 +228,8 @@ with the following files:
             0=3D0x33;1=3D0x7f;2=3D0x7f;3=3D0x7f
=20
         * To change the mbm_local_bytes to count all the slow memory reads
-          on domain 1. To achieve this, the bits 4 and 5 needs to be set
-          which is 110000b (in hex 0x30).
+          on domain 1 (the bits 4 and 5 needs to be set, which means 11000=
0b
+          {in hex 0x30}):
           ::
=20
             # echo  "1=3D0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_con=
fig
@@ -540,20 +540,21 @@ Memory bandwidth domain is L3 cache.
 	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...
=20
 Slow Memory bandwidth Allocation (SMBA)
--------------------------------------------------
-AMD hardware can support slow Memory bandwidth Allocation feature.
+---------------------------------------
+AMD hardwares support Slow Memory bandwidth Allocation (SMBA) feature.
 Currently, CXL.memory is the only supported "slow" memory device.
-With the support of SMBA feature the hardware enables bandwidth
-allocation on the slow memory devices. If there are multiple slow
-memory devices in the system, then the throttling logic groups all
-the slow sources together and applies the limit on them as a whole.
+With the support of SMBA, the hardware enables bandwidth allocation
+on the slow memory devices. If there are multiple such devices in the
+system, the throttling logic groups all the slow sources together
+and applies the limit on them as a whole.
=20
-The presence of the SMBA feature(with CXL.memory) is independent
-of whether slow memory device is actually present in the system.
-If there is no slow memory in the system, then setting a SMBA limit
-will have no impact on the performance of the system.
+The presence of SMBA (with CXL.memory) is independent of slow memory
+devices presence. If there is no such devices on the system, then
+setting the configuring SMBA will have no impact on the performance
+of the system.
=20
-Slow Memory bandwidth domain is L3 cache.
+The bandwidth domain for slow memory is L3 cache. Its schemata file
+is formatted as:
 ::
=20
 	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...
@@ -575,11 +576,13 @@ which you wish to change.  E.g.
=20
 Reading/writing the schemata file (on AMD systems)
 --------------------------------------------------
-Reading the schemata file will show the state of all resources
-on all domains. When writing the memory bandwidth allocation you
-only need to specify those values in an absolute number expressed
-in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you
-need to specify the value 16 (16 * 1/8 =3D 2). For example:
+Reading the schemata file will show the current bandwidth limit on all
+domains. The allocated resources are in multiples of one eighth GB/s.
+When writing to the file, you need to specify what cache id you wish to
+configure the bandwidth limit.
+
+For example, to allocate 2GB/s limit on the first cache id:
+
 ::
=20
   # cat schemata
@@ -593,11 +596,11 @@ need to specify the value 16 (16 * 1/8 =3D 2). For ex=
ample:
=20
 Reading/writing the schemata file (on AMD systems) with SMBA feature
 --------------------------------------------------------------------
-Reading the schemata file will show the state of all resources
-on all domains. When writing the memory bandwidth allocation you
-only need to specify those values in an absolute number expressed
-in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you
-need to specify the value 64 (64 * 1/8 =3D 8).  E.g.
+Reading and writing the schemata file is the same as without SMBA in
+above section.
+
+For example, to allocate 8GB/s limit on the first cache id:
+
 ::
=20
   # cat schemata

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--1jn1q8Ke7yaH7q25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0UyFQAKCRD2uYlJVVFO
o1RBAP42+k8eQUHo+LBXrd43boOV5PpxfQMGL95WzuDr4FSTggEAgpuCEs51bFBG
S8WNGLfC3jjVwCXXab8/IbOi7MpTgQQ=
=62GJ
-----END PGP SIGNATURE-----

--1jn1q8Ke7yaH7q25--
