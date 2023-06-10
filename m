Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF6572AF8C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjFJWhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 18:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJWhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:37:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A349E5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:37:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686436654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9vitvOPG+xvJzjdSeWfwXEva3xzCwWxkPX4DK6Mf4U=;
        b=IxZafuqLIwQqtJkNaNtTQvkdYguIHmycvFJHzwIeFLlDzK8+xj6N29jfeGZPo2ilpTz3OE
        pNTFH5vMBlydFQAfgUthN91bQCyF9kpHV+vRlXBYuGDUoU/TRhpXFGujKxFx8yt45uuqnr
        tdZIhopQhS8tGN3jdeRl1aCR9GiZrOPBtpiutuFMgIwY71E2MRtEeLMZzFE2nYyHJVSRKl
        dz+Nz6zVHZpoNQFp8lh5HBFwTNfjeSfwLatjM85BVFcTk4BfD5L/S5esSDjbUvSNYGniW2
        sYDRucEaIMtTfrcI02uazpDC2iegA0dOZTo7g+lLaH3/uuuBI7jn7y/fauttfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686436654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9vitvOPG+xvJzjdSeWfwXEva3xzCwWxkPX4DK6Mf4U=;
        b=cv72YEIJY8cfNJhosTjM/KT7w10M44RH82b1AaRQkqLulMDQfsaBZSDo00oSzYIRezTmW4
        Nu8wfbdhYH6TasDw==
To:     Breno Leitao <leitao@debian.org>, bp@alien8.de,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com
Cc:     leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
In-Reply-To: <20230203120615.1121272-1-leitao@debian.org>
References: <20230203120615.1121272-1-leitao@debian.org>
Date:   Sun, 11 Jun 2023 00:37:34 +0200
Message-ID: <87352z7xld.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03 2023 at 04:06, Breno Leitao wrote:
> Right now it is not possible to disable CPU vulnerabilities mitigations
> at build time. Mitigation needs to be disabled passing kernel
> parameters, such as 'mitigations=off'.
>
> Create a new config option (CONFIG_CPU_MITIGATIONS_DEFAULT_OFF) that
> sets the global variable `cpu_mitigations` to OFF, instead of AUTO. This
> allows the creation of kernel binaries that boots with the CPU
> mitigations turned off by default, and does not require dealing kernel
> parameters.

Why? What's the justification

Just because we do not have not enough kernel config items yet, does not
count.

Thanks,

        tglx
