Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1437B66E5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjAQS0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAQSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:23:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48AD3D927;
        Tue, 17 Jan 2023 09:57:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id br9so12934104lfb.4;
        Tue, 17 Jan 2023 09:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zSi0uOMA2RCVmp8V5E3w60uQumJE+FV2d1gNUaY7WlI=;
        b=G++GoLT1Fuqk9OurfLexVgstS6wegfJJ5t5lARRXSCD1Ov6kI/aQXWDGIRVbuRnk/b
         y9160UuErtPnayYkIPSgcpWMUxIn3szmb5O5YiSOtgtaqQgRdrKqpahqWK/d2s4yYbXF
         1ji7IN1gOe6YcSdxK4sXLDCyPwBjpn9hK8n/3hH0oz8yehFY5da4zMnIWpqPwttOJLFE
         Oi1K+gckIURP17btxhnhFSz8dReXlmdX5hzEHDLxO40CBp6sJsePbt6LkUDlUI7m3F1u
         LUQcBHeSD9JWdC7reQm4atx7z+kfnyww60mPqvDQIMwX5+vnWRC6X3a79ppxsINMoQwf
         Dahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSi0uOMA2RCVmp8V5E3w60uQumJE+FV2d1gNUaY7WlI=;
        b=cySP0li0sivQUWP5QskZ3EuMI45hGZ2wfYkj4MtC9K/KGXd6XAqw/Wp71dgR19Y5ty
         duMZdib6EhkHwHs6kx1BiMgNzmBop6yZ4WIZgPxjXo3SKF9aBYxM3xrQ8XlMU6PQC9JN
         O+4SNwVpuy9no4jMpTryrSIh5PiF+S8wGMa8M2KxfBk0U6l9O7g83VHUN0yt3IPTa1Y6
         h+9LXsDuTBEly9uR7sT3Z4yg3ybudpfdIfpMU86F2fM+VePG6vedvCUUinbemEysVdwC
         6Yz+Ql/v1MmbkjEd5xTFofrwA4iOR5mmORrAhl/JZjZR+6lQ5P9fUJzDBekQOL9uQN3u
         A3CQ==
X-Gm-Message-State: AFqh2kpNEXyJDLNjyErDfwQnBY9sYfsCGp8yIdEMwYtq8sBYu7dXU2gP
        Ys2YJR/d+xhtaPtOGDhtR6KJLukDxWNiCVA0Qas=
X-Google-Smtp-Source: AMrXdXsPcV1ZUirMk99XeiaROwkoCXGuGD/tuFxt7LN0dXWiI3puoY+PW9Mjr4AejAK1eBgT4mjTETVaUoNQt8aH41A=
X-Received: by 2002:a05:6512:96a:b0:4c4:dd2a:284f with SMTP id
 v10-20020a056512096a00b004c4dd2a284fmr253673lft.440.1673978254596; Tue, 17
 Jan 2023 09:57:34 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUOckm1kwOEZhSw8zsaL5z7r8uczwiKeKGEVioZ=GeFNg@mail.gmail.com>
 <7964ec80-4d02-6c9c-ff9e-a6a8a0c427c3@intel.com> <004e01d92a93$79f21e50$6dd65af0$@telus.net>
In-Reply-To: <004e01d92a93$79f21e50$6dd65af0$@telus.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 17 Jan 2023 18:56:57 +0100
Message-ID: <CA+icZUUMYMzG=w6o_6s1QxgTaRoZFCbkVFh2-Oa_BH-osyEjBw@mail.gmail.com>
Subject: Re: [6.2-rc4] tools: {amd,intel}_pstate_tracer: make -C tools/ clean
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, li.meng@amd.com,
        linux-kernel@vger.kernel.org, Jinzhou Su <Jinzhou.Su@amd.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 5:48 PM Doug Smythies <dsmythies@telus.net> wrote:
...
> And if I do this:
>
> doug@s19:~/kernel/linux$ git diff
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 5f195ee756d6..5fd1424db37d 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -7,11 +7,6 @@ all:
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>
> -ifeq (x86,$(ARCH))
> -TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> -TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> -endif
> -
>  TEST_PROGS := run.sh
>  TEST_FILES := basic.sh tbench.sh gitsource.sh
>
> The source files do not get deleted with Sedat's test.
>

$ LANG=C LC_ALL=C make -C tools/ clean 2>&1 | tee ../make-log_tools-clean.txt

$ git status -s
M tools/testing/selftests/amd-pstate/Makefile

$ git diff
diff --git a/tools/testing/selftests/amd-pstate/Makefile
b/tools/testing/selftests/amd-pstate/Makefile
index 5f195ee756d6..5fd1424db37d 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -7,11 +7,6 @@ all:
uname_M := $(shell uname -m 2>/dev/null || echo not)
ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)

-ifeq (x86,$(ARCH))
-TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
-TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
-endif
-
TEST_PROGS := run.sh
TEST_FILES := basic.sh tbench.sh gitsource.sh

$ egrep 'amd-pstate|pstate_tracer' ../make-log_tools-clean.txt
88:make[2]: Entering directory
'/home/dileks/src/linux/git/tools/testing/selftests/amd-pstate'
90:make[2]: Leaving directory
'/home/dileks/src/linux/git/tools/testing/selftests/amd-pstate'

Confirmed.

-Sedat-
