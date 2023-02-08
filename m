Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161FF68F13E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjBHOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBHOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:52:17 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F64ABE3;
        Wed,  8 Feb 2023 06:52:09 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so2739502pjd.2;
        Wed, 08 Feb 2023 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4AuJ33QMhE8O5uKA+tVNztfzfpqjwyqmgh1FH0aNv0=;
        b=Ol8/POc4j04Yl6QgnfKBLLAoC1mFqqBBteWvraF1984YIb2ehIo133XeVHKEg0byRW
         7AE7YOcb3R/ZFhPRZLv3J+lzX5HcKNPLCCm7fwmHol9l7ko2hFH4Ma/9AEV/F5u44xJj
         J7VnqkXAx3gYM8/4qb5q1ZYfYIWnraxqbEUhvJGyoiTns5rEUxXnAGDPwLas3qZxC6Wc
         ikpIb2IdeeHO1OnGJFaZI2LJxSmaIxHw2gCJFlAJ5BCdzgl3Z1uTlzp/SYaYna0qNifi
         W4BVHJxWSVTBAkwoES2jPdTESc8xBsOQe1E/yUq+pHTszmVmekHZp8ZneK7+gsvIjWZg
         8f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4AuJ33QMhE8O5uKA+tVNztfzfpqjwyqmgh1FH0aNv0=;
        b=YkBISGu7h0rYlTcg5AOrJiOp+DC3fu1q0CekkhYo0Cm7Q/lcyxg0pyWrlu+uL3peF+
         L4ItoIFqMhi/K/duvz5x5rSyMxZID8VDnTZW5JzKO/Vxj/WjOClP8Yz8bFF8cigddwOw
         0jsWeG0I/HCL5TatVC5JMO34ArVFBpJ8pYg57N1I4JHpKBg8Ow6gncoUA6ZUli5t3wln
         8re1i/weo5YxyiwpZyvzXoQAxWWzfmiw3FJgbfrWrdlUze05Xb5iWq/fiTAt/uffgHpm
         rFKfxThF8CSPQr6pn7FfEBuU2dzmQH7XFdeFLaykR1yrgGvrcwARF6T2+kWin67S2aph
         xjxw==
X-Gm-Message-State: AO0yUKW9zpStQXS2uDbY6Fwj8AsCiOFj6MdtqwLNztumQIPgMoAZxZoK
        KZJ6Z7BTtMt0tQYOkBlrheq3PNzbVrd49g==
X-Google-Smtp-Source: AK7set+syKrFhLQiWqfx/xno6zZ8BumMLcZEYlvdJK4UBGeFFaEGsb9cllDducDC8YyLJDsHjEy3yw==
X-Received: by 2002:a05:6a21:e208:b0:a2:ed21:d820 with SMTP id by8-20020a056a21e20800b000a2ed21d820mr5146264pzc.42.1675867928652;
        Wed, 08 Feb 2023 06:52:08 -0800 (PST)
Received: from kazuki-mac ([2400:4051:ea3:5910::19a])
        by smtp.gmail.com with ESMTPSA id 10-20020aa7910a000000b00582f222f088sm1695457pfh.47.2023.02.08.06.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:52:08 -0800 (PST)
From:   Kazuki <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki <kazuki@kazuki-mac>
Date:   Wed, 8 Feb 2023 23:52:03 +0900
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230208145203.43gqavgsp7n3vm7y@kazuki-mac>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <20230208112031.sdfuluajjerf4wwp@kazuki-mac>
 <20230208141658.kede5ylqk4zqvrnj@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208141658.kede5ylqk4zqvrnj@bogus>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sent the wrong bit of code, sorry. Correct code is:

static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
			   const char *buf, size_t n)
{
	suspend_state_t state;
	int error;

	error = pm_autosleep_lock();
	if (error)
		return error;

	if (pm_autosleep_state() > PM_SUSPEND_ON) {
		error = -EBUSY;
		goto out;
	}

	state = decode_state(buf, n);
	if (state < PM_SUSPEND_MAX) {
		if (state == PM_SUSPEND_MEM)
			state = mem_sleep_current;

		error = pm_suspend(state);
	} else if (state == PM_SUSPEND_MAX) {
		error = hibernate();
	} else {
		error = -EINVAL;
	}

 out:
	pm_autosleep_unlock();
	return error ? error : n;
}

power_attr(state);
