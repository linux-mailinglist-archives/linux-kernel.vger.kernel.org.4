Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775DE7434E3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjF3GTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjF3GTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:19:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324FB35B7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:18:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc0981743so12917125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688105933; x=1690697933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zr5rF21wCxAgCyW7DuVdlBs4zYqth3c0/Oqjm5ElJHw=;
        b=QX1GbHZHOMS/I6qduXCOvQHqbJKZov2iJoruAGrNr6y2rYLwgeZN26SBlS64A1M1Lj
         YW9umBOvF6cfJPlxpPZJcwrucrulpyAjKTfGH8C6id3fVVhYx3LfyfMhd1K+7993wIOP
         qMSfysesD8oqYY+3aQer4bI68T87PwQ15b1oWm9Tqfi42jL7nyqcf0HniCxzrt8+UnCG
         tsWojuyS+Td5TbMp45LEdHvV9sBqY8kK9V6QlsVYVRzUxMbikZkKJ+xGE/w+ZyaiynLS
         bAboVJkBsOuEvUvMa1nUkckbSIYsJmuMNA0GyzxFzyMFZDTvX3m6MUZVbFNw4F/M30QA
         mfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688105933; x=1690697933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr5rF21wCxAgCyW7DuVdlBs4zYqth3c0/Oqjm5ElJHw=;
        b=MQ5iTxhswCWpt8hvSRCvFCBjf9o2ChbM8dwKTna2fKWlxN8gs6VTrOfh4Fdq8p8F4V
         lCucGh2DZFapFikVCPailG0AbJuf/ZcZ+1D/+qn5Zk3Lcn516f93f+35WoVTrIywga/7
         JF3PwXbwpWhCN4ef7210oWnffoIyPSLwxCAB93oV2iyrJJzikRWwxzwToqsbamgA6gq/
         a1qnFI7NeZfzG/qy6xrf2IjoNFgyNjAh1Ws7FDDW7boREYoqvmddgzIixriujtvV85dd
         XipD2Sn29AfXq8PR4J53Sgt5OCmXl+4jt6v8zQqwmmXsIrD2fbKsKHPv7302pSB2zQ5o
         O09w==
X-Gm-Message-State: AC+VfDycThxZwttZfC4oE5VojPYI2pZZt5GBPWfNRsPxl6whdmxAy3+b
        EbjvxQxD0CqM/TsDammsFKpukg==
X-Google-Smtp-Source: ACHHUZ4nsmWQ8xs40ltmSBhxGzZcDTQ5vdYqASDgeCzIG3MODNSzst18118PLv/Va6+AHyucJZwfDg==
X-Received: by 2002:a05:600c:2201:b0:3fa:91d2:55b6 with SMTP id z1-20020a05600c220100b003fa91d255b6mr1098206wml.9.1688105933535;
        Thu, 29 Jun 2023 23:18:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fbc90e030csm191540wmc.37.2023.06.29.23.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 23:18:51 -0700 (PDT)
Date:   Fri, 30 Jun 2023 09:18:48 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild@lists.linux.dev, Eddie James <eajames@linux.ibm.com>,
        linux-hwmon@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, lakshmiy@us.ibm.com
Subject: Re: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs
 attribute
Message-ID: <07dac6f4-5b40-4a62-b1a9-257ec13938ed@kadam.mountain>
References: <20230627184027.16343-1-eajames@linux.ibm.com>
 <b12935a2-a8b7-4d70-8c7d-6fd1e92037c2@kadam.mountain>
 <45a29025-4c06-4f88-b82f-a8002c25c376@kadam.mountain>
 <1a27469a-4cdb-8cf0-c539-05103f2e0b8f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a27469a-4cdb-8cf0-c539-05103f2e0b8f@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 12:09:17PM -0700, Guenter Roeck wrote:
> On 6/29/23 11:59, Dan Carpenter wrote:
> > On Thu, Jun 29, 2023 at 09:53:16AM +0300, Dan Carpenter wrote:
> > > d2c6444389b625 Eddie James 2023-06-27  22  	char out[8];
> > > d2c6444389b625 Eddie James 2023-06-27  23  	int rc;
> > > d2c6444389b625 Eddie James 2023-06-27  24  	int i;
> > > d2c6444389b625 Eddie James 2023-06-27  25
> > > d2c6444389b625 Eddie James 2023-06-27  26  	rc = pmbus_lock_interruptible(client);
> > > d2c6444389b625 Eddie James 2023-06-27  27  	if (rc)
> > > d2c6444389b625 Eddie James 2023-06-27  28  		return rc;
> > > d2c6444389b625 Eddie James 2023-06-27  29
> > > d2c6444389b625 Eddie James 2023-06-27  30  	rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, data);
> > > d2c6444389b625 Eddie James 2023-06-27  31  	pmbus_unlock(client);
> > > d2c6444389b625 Eddie James 2023-06-27  32  	if (rc < 0)
> > > d2c6444389b625 Eddie James 2023-06-27  33  		return rc;
> > > d2c6444389b625 Eddie James 2023-06-27  34
> > > d2c6444389b625 Eddie James 2023-06-27  35  	for (i = 0; i < rc && i < 3; ++i)
> > > d2c6444389b625 Eddie James 2023-06-27 @36  		snprintf(&out[i * 2], 3, "%02X", data[i]);
> > > 
> > > If data[i] is negative this will print FFFFFFF1 etc.  (This is an x86
> > > config...  Did we ever merge that patch to make char signed by default?)
> > 
> > I meant unsigned not signed.  But actually we debated both ways...
> > Signed by default would annoy PowerPC devs since they try to really
> > lean into the fact that char is unsigned on that arch.  :P
> > 
> > https://lwn.net/Articles/911914/
> > 
> 
> As if anything would be easy nowadays ;-). Anyway, in this case, the array
> should be explicitly unsigned, so changing the type to u8 was the right
> thing to do. Also, the driver should be usable on non-Intel systems,
> which is another reason to make the type sign-specific (even more so in
> the context of the above discussion).

Actually we did make char unsigned.  I don't know if I'm super
comfortable with code that assumes char is unsigned.  It's makes
backporting trickier.  But this is definitely a false positive so I have
silenced the warning in Smatch.

regards,
dan carpenter

--- a/check_kernel_printf.c
+++ b/check_kernel_printf.c
@@ -827,7 +827,7 @@ hexbyte(const char *fmt, int fmt_len, struct expression *arg, int vaidx, struct
                sm_warning("could not determine type of argument %d", vaidx);
                return;
        }
-       if (type == &char_ctype || type == &schar_ctype)
+       if (type_signed(type) && (type == &char_ctype || type == &schar_ctype))
                sm_warning("argument %d to %.*s specifier has type '%s'",
                       vaidx, fmt_len, fmt, type_to_str(type));
 }
