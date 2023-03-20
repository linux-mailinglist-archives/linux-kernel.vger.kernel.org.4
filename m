Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B72D6C1116
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjCTLpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCTLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:45:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257452069C;
        Mon, 20 Mar 2023 04:45:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x17so14515237lfu.5;
        Mon, 20 Mar 2023 04:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEHSkSsT1auJnkD1k0lUA29bx/Ib/zqnUvokdeITfEo=;
        b=qoIIN/X93SlWDs0PXFHLkE7u1YWDYnGDPAQtgUO4tYJn8Rfn7BMhcmj4h3PuY9gWtc
         EhQSy0fjAXIhMbOvPO7djjKynZfRvdpp+rNbBHJ/48x6RB/iqTVOty+3dXzdXpr2YULq
         eYimCY9etwWZ8B3wGMJsZ/5AEMPKqR5V5ppHSvB2RRS0pu9ydwaYgwSeN7efZXkKD2wf
         3GmagUiI/eUXa/fITuf/PlhUNhVziq4LXNCLOGBO3lwf2lG3j8hj9mXRaL3LkbLmgbn2
         nQ+dYW++xos/dO8dnLhA6WTeeLU3ruTU3/f8l33SbG+LsWQdFBtaDWsopKsqRwGtk0lk
         T/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679312730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEHSkSsT1auJnkD1k0lUA29bx/Ib/zqnUvokdeITfEo=;
        b=NPuSkvGMn3HJ0op9u6lEPvSWg1Ff6pt6zyVyfmDxYvVz+nzQKnB3GaAjz6D0t9nWNI
         FJMhlIwkDT/BbYo/Uaz+dPlg5CFGcyh6PvrqoqxnCjImPkS2qM61VNGohr/ZGV+a4JlN
         oImbuGT3j0vJs0fs4FQqCPB/T0wSPBHN1k0Awd9wQGqJoEEV594lhC+qaETwmYsWMGXM
         o7RldPeT0LU2iRyJ3n9Lfb9WVY402Mx2fRanJwwACcJaG5TMhHsa9aZXx9Y5UrtjttR4
         kg3iveUR6JdUhUylZCPJezGDVP0m+IKzzCNRENl6YnicXOk0M2VC2ltElaqiPaBWRwaL
         Nw5g==
X-Gm-Message-State: AO0yUKWoc0GAaq1R6Rqv+g/gbL6FQX974/cxUSezJDWNjEvgSw06xKM+
        /sg0J9Z4Su+H/nmOgCaLvTA=
X-Google-Smtp-Source: AK7set94nfBfxtpNV5AkyI1/PEssWOGhiMHEMnMDIVJBtHXo3G+el13tnDKa7fNkf5UyX9vaZgEIKg==
X-Received: by 2002:ac2:5623:0:b0:4db:38a2:e985 with SMTP id b3-20020ac25623000000b004db38a2e985mr6724334lff.62.1679312730451;
        Mon, 20 Mar 2023 04:45:30 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id p20-20020a19f014000000b004db44f782aesm1657416lfc.4.2023.03.20.04.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:45:30 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-22) with ESMTP id 32KBjPQ4007560;
        Mon, 20 Mar 2023 14:45:27 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 32KBjF1t007559;
        Mon, 20 Mar 2023 14:45:15 +0300
Date:   Mon, 20 Mar 2023 14:45:15 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Zev Weiss <zweiss@equinix.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v8 10/13] hwmon: peci: Add cputemp driver
Message-ID: <ZBhHS7v+98NK56is@home.paul.comp>
References: <20220208153639.255278-1-iwona.winiarska@intel.com>
 <20220208153639.255278-11-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208153639.255278-11-iwona.winiarska@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are seeing wrong DTS temperatures on at least "Intel(R) Xeon(R)
Bronze 3204 CPU @ 1.90GHz" and most probably other Skylake Xeon CPUs
are also affected, see inline.

On Tue, Feb 08, 2022 at 04:36:36PM +0100, Iwona Winiarska wrote:
> Add peci-cputemp driver for Digital Thermal Sensor (DTS) thermal
> readings of the processor package and processor cores that are
> accessible via the PECI interface.
...
> +static const struct cpu_info cpu_hsx = {
> +	.reg		= &resolved_cores_reg_hsx,
> +	.min_peci_revision = 0x33,
> +	.thermal_margin_to_millidegree = &dts_eight_dot_eight_to_millidegree,
> +};
> +
> +static const struct cpu_info cpu_icx = {
> +	.reg		= &resolved_cores_reg_icx,
> +	.min_peci_revision = 0x40,
> +	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> +};
...
> +	{
> +		.name = "peci_cpu.cputemp.skx",
> +		.driver_data = (kernel_ulong_t)&cpu_hsx,
> +	},

With this configuration we get this data:

/sys/bus/peci/devices/0-30/peci_cpu.cputemp.skx.48/hwmon/hwmon15# grep . temp[123]_{label,input}
temp1_label:Die
temp2_label:DTS
temp3_label:Tcontrol
temp1_input:30938
temp2_input:67735
temp3_input:80000

On the host system "sensors" report

Package id 0:  +31.C (high = +80.C, crit = +90.C)

So I conclude Die temperature as retrieved over PECI is correct while
DTS is mis-calculated. The old downstream code in OpenBMC was using
ten_dot_six_to_millidegree() function for conversion, and that was
providing expected results. And indeed if we reverse the calculation
here we get 80000 - ((80000-67735) * 256 / 64) = 30940 which matches
expectations.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
