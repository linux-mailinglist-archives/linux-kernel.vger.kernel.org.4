Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084A16022B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJRDea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJRDd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:33:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335EE57207;
        Mon, 17 Oct 2022 20:25:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so12760782pjl.3;
        Mon, 17 Oct 2022 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inxwZbHCosG38Mzi0t/8Jt5QPcVmfrtnyVKQMr/6zMY=;
        b=D1QWW2AwdELMm3BZnaEEvULxbnvRMyBEA1RKmIWYC0vjPEnKyoYCwy8l1nxeL2TXcm
         HRPKP9kSTfIEkxD2dlikTAGiF3wdjRmBTzwLvXzsP0nXudITwmbzzA79acSNO6TBCy6x
         RzCxSiMHnDKjHAZKLEVsDzlyB9rsuGUkozY4WD7ThoA1swBGD/sZVQC9VGshM3TLt6dc
         JkwnJJbUVNbPcZka426xh7JBx7F5Ar9TlKYUBO3oJVy5tLtqAF8crWCJ/UT7Jm2D2Xpp
         qimCIsBiDZ6mGMs8/SB0hLKyZatB4WisYCmWWki3Xk+O/mOpJvRjxuT5rDpQq56Z8qfV
         /3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inxwZbHCosG38Mzi0t/8Jt5QPcVmfrtnyVKQMr/6zMY=;
        b=dObmU6PosM3XR7D5TEo8JkJyIOZByb2JJzw9+eqcDQttfo/s7jOcLtJue2xnrK1xvl
         3lWzaIhF+UbWv5dchBPFJFtecHwMlcttsgv5q1hsn5qQWTqJO8EzdUtl03eflSVjQ0XO
         E4MeiBhLQZjcdvoU+0VnUQkS/3DVAuSOPHs8uTdJ5flV7aGYKTq/Fw+Pwv2YOSKRqPx0
         Z4+cBE7XxwTuQoy0TVVWByyfSNtENj+mXsRMXghSSc7sYmaG2TEbppG030AOUsllzJw1
         f9i7nJNPc4yHhe0mRHMx+Dyo2Oh42POLA7ig9L3Iu7PigOPWjNWbT34+ytRSFTbTzkr7
         D0RA==
X-Gm-Message-State: ACrzQf3HcHkoN2GfVBumhwnfzY6kCNe2zQQJ0SmKW932TVXh6It53w0Q
        Hzzaxr5a0Dx+36rxBgsD4qM=
X-Google-Smtp-Source: AMsMyM4tVQl65LZFscZ1skFXl51ahc6l3kWLS4Y1ORVbb9esgJ6ZSO6zO1QxABEWPPqvptnzYTQ4Lw==
X-Received: by 2002:a17:90b:1242:b0:20a:f75c:de7 with SMTP id gx2-20020a17090b124200b0020af75c0de7mr37880370pjb.70.1666063470857;
        Mon, 17 Oct 2022 20:24:30 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902e74d00b0017854cee6ebsm7473486plf.72.2022.10.17.20.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 20:24:30 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A652B103AE0; Tue, 18 Oct 2022 10:24:27 +0700 (WIB)
Date:   Tue, 18 Oct 2022 10:24:27 +0700
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
Subject: Re: [PATCH v7 12/12] Documentation/x86: Update resctrl.rst for new
 features
Message-ID: <Y04ca9ZgS44tBsTk@debian.me>
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604565437.5345.14867510739122394750.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FTXa/D3TyRNBlERd"
Content-Disposition: inline
In-Reply-To: <166604565437.5345.14867510739122394750.stgit@bmoger-ubuntu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FTXa/D3TyRNBlERd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 05:27:34PM -0500, Babu Moger wrote:
> Update the documentation for the new features:
> 1. Slow Memory Bandwidth allocation (SMBA).
>    With this feature, the QOS  enforcement policies can be applied
>    to the external slow memory connected to the host. QOS enforcement
>    is accomplished by assigning a Class Of Service (COS) to a processor
>    and specifying allocations or limits for that COS for each resource
>    to be allocated.
>=20
> 2. Bandwidth Monitoring Event Configuration (BMEC).
>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>    are set to count all the total and local reads/writes respectively.
>    With the introduction of slow memory, the two counters are not
>    enough to count all the different types of memory events. With the
>    feature BMEC, the users have the option to configure mbm_total_bytes
>    and mbm_local_bytes to count the specific type of events.
>=20
> Also add configuration instructions with examples.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst |  139 +++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 137 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 71a531061e4e..d0b4e1a2cb8d 100644
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
> +        * To change the mbm_total_bytes to count only reads on domain 0,
> +          the bits 0, 1, 4 and 5 needs to be set, which is 110011b in bi=
nary
> +          (in hexadecimal 0x33):
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
> +          on domain 1, the bits 4 and 5 needs to be set, which is 110000b
> +          in binary (in hexadecimal 0x30):
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
> @@ -464,6 +539,26 @@ Memory bandwidth domain is L3 cache.
> =20
>  	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...
> =20
> +Slow Memory bandwidth Allocation (SMBA)
> +---------------------------------------
> +AMD hardwares support Slow Memory bandwidth Allocation (SMBA) feature.
> +Currently, CXL.memory is the only supported "slow" memory device.
> +With the support of SMBA, the hardware enables bandwidth allocation
> +on the slow memory devices. If there are multiple such devices in the
> +system, the throttling logic groups all the slow sources together
> +and applies the limit on them as a whole.
> +
> +The presence of SMBA (with CXL.memory) is independent of slow memory
> +devices presence. If there is no such devices on the system, then
> +setting the configuring SMBA will have no impact on the performance
> +of the system.
> +
> +The bandwidth domain for slow memory is L3 cache. Its schemata file
> +is formatted as:
> +::
> +
> +	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...
> +
>  Reading/writing the schemata file
>  ---------------------------------
>  Reading the schemata file will show the state of all resources
> @@ -479,6 +574,46 @@ which you wish to change.  E.g.
>    L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff
>    L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff
> =20
> +Reading/writing the schemata file (on AMD systems)
> +--------------------------------------------------
> +Reading the schemata file will show the current bandwidth limit on all
> +domains. The allocated resources are in multiples of one eighth GB/s.
> +When writing to the file, you need to specify what cache id you wish to
> +configure the bandwidth limit.
> +
> +For example, to allocate 2GB/s limit on the first cache id:
> +
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
> +--------------------------------------------------------------------
> +Reading and writing the schemata file is the same as without SMBA in
> +above section.
> +
> +For example, to allocate 8GB/s limit on the first cache id:
> +
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

Finally LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--FTXa/D3TyRNBlERd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY04cawAKCRD2uYlJVVFO
o7BnAQCgJ6fV2UoC+hafwMJv87uRNhD2dP9qs+sTb/rsZRQ9iAEAvXjKoArwfGhy
b1KkOm8x3Sm/BJiOkGIvUjiNBzN3Og4=
=u4gn
-----END PGP SIGNATURE-----

--FTXa/D3TyRNBlERd--
