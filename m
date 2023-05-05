Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1AE6F7C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjEEFDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEFDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:03:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026EC3C3A;
        Thu,  4 May 2023 22:03:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52c6504974dso1108874a12.2;
        Thu, 04 May 2023 22:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683263012; x=1685855012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9P08im9sPfCiPnd7jByL05GkSqJFCFxG7xsuCu021rc=;
        b=q8HM1T5uCbzfzDlEbKV08u3a/aqw6+7ouKpsUrq6qyKhR3gal0y6Jm7vCM7S71lmYj
         1oLYzPZDJhW/0oHO/F9cbDWz5BbeYFRCF6v4GsjMYusdmk421xKWysoGoH/Go7yYjmKd
         EXsqMc8LDx4MqJ674Wp4DnosnjSssZTakDFftrLvwNPNqh+dkuE4y4W2hgfi++Vy07Zo
         MtS6zMw9sEOE9WP1JXj2PjHGbdil6b2xclggUURoHF4aEpxg9w9Afic3N5K8kaNEAaWs
         FoJJvHBrJcSBKosFCFW1epkWYwZYH2KfuC3ONx2zOPgHB4Xa4SAJEKJjqLeqFasZHxj/
         2GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683263012; x=1685855012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P08im9sPfCiPnd7jByL05GkSqJFCFxG7xsuCu021rc=;
        b=WeXLNppndkfrZyZnZxm5qdeXr6UfaQddNEEM6ZPNv6h617PaLKOumq3+ITCrn+RuoQ
         76U4FBY7jNlVFJ5EeIxEOr0wL1kxFkEE6dPR66EkgmsFOpm8KmMzhODnkj0CGZ4QxsrW
         LKgR0IBIrNcyZYIRgy8uwxzqe8NesWBElHQi98HjZ/BRp0ZEL0FfNQ0QpSxuhSvKhHA7
         lM7+N1q4lsMDXdDvn8fa/2IB2U9xBKW8VfhjFvN4yyNgrf7iE23XpWWdvd97dAoV1+Dq
         Kgn8y4QqEF/UHJ3biyeYwyEq0kEM1DqmQmH5aYUYVsIx8GSPZL/24ua0OJFrOLGHb2j1
         aDYw==
X-Gm-Message-State: AC+VfDwKbOFjtUxH7iAI4r1r4UXF5uPyWzWz0kxaFH/YcS4IolETRt+L
        qIfAkpwf5Z/rhPXHYPjMxhk=
X-Google-Smtp-Source: ACHHUZ7UEaifxFSFaaQhmiKJiRCxXq6tFGzRcH07iM296lkhN/Rk5255PRVQMiXSh6OYEGdCn2MJ/A==
X-Received: by 2002:a05:6a20:1608:b0:f2:c2a3:3a1 with SMTP id l8-20020a056a20160800b000f2c2a303a1mr274751pzj.43.1683263012397;
        Thu, 04 May 2023 22:03:32 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-25.three.co.id. [180.214.233.25])
        by smtp.gmail.com with ESMTPSA id t9-20020a635f09000000b00514256c05c2sm665250pgb.7.2023.05.04.22.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 22:03:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3A353106861; Fri,  5 May 2023 12:03:29 +0700 (WIB)
Date:   Fri, 5 May 2023 12:03:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 08/11] Documentation/hwmon: Revise userspace tools
 documentation
Message-ID: <ZFSOIXLCnd01ofBv@debian.me>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-9-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504075752.1320967-9-james@equiv.tech>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 12:57:49AM -0700, James Seo wrote:
> +If needed, sources may be found at https://hwmon.wiki.kernel.org/lm_sensors.
> +Basic compilation, installation, and uninstallation may be accomplished with
> +``make all``, ``make install``, and ``make uninstall``, respectively.
> +

The sources is on GitHub:

---- >8 ----
diff --git a/Documentation/hwmon/userspace-tools.rst b/Documentation/hwmon/userspace-tools.rst
index 79c932954e4af5..fd96ea92f72eea 100644
--- a/Documentation/hwmon/userspace-tools.rst
+++ b/Documentation/hwmon/userspace-tools.rst
@@ -44,9 +44,9 @@ Most Linux distributions provide the ``lm-sensors`` suite as a package.
 It is recommended that you use this package for ease of installation.
 Please consult your Linux distribution's documentation for more information.
 
-If needed, sources may be found at https://hwmon.wiki.kernel.org/lm_sensors.
-Basic compilation, installation, and uninstallation may be accomplished with
-``make all``, ``make install``, and ``make uninstall``, respectively.
+If the distribution package isn't available, sources can be obtained at
+`GitHub <https://github.com/lm-sensors/lm-sensors>`_.
+See ``INSTALL`` in the sources for how to build the suite.
 
 Usage
 -----

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
