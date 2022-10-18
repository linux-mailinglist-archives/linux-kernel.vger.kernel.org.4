Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5671603283
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJRSbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJRSbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:31:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824679EF1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:31:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 10so14706237pli.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iy+LFikzHTs1J48QAEAHAm5YGvlj/kbcEpiv2VdTbbk=;
        b=iBu3LRdcEWjy4sMWECJg5kLUDIVKNFjlERJIDz8f280TVk7Nv6Zz0y+8eiWnZKTeah
         JrR6L/bfoap5pjeJ0q9SJKt/qhWjklw5U0jpeHEj9DrMgbyu7WCZwDeXHXGKqBg6mF1C
         JLTJOHwjDJOXfQfTnDbVyIxYspizRanVV0kKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iy+LFikzHTs1J48QAEAHAm5YGvlj/kbcEpiv2VdTbbk=;
        b=DqR+tJmO+WhGqct2ITPmoEZwpR9nvVqEeCamDEx32qxkvmFGU3vcKB1pIqwudQyZUG
         w73JT17GXyp6c7ejIMY3Bpx9GpgRm6js3bdBisAoJxh7xrbruY7QJheVWOQwUow4wIRN
         BLgQKG5BBaoLh3BH7zIecTPfhFvHHxn+Ku7EODAK4TO8CK7lhB2z96xJS9D551G1z8+c
         8cwagU2rholcnj/HMFHPfibd81tW2ErSFm3IsMr0A8a6sOjY2oLqEKUJDFAAHcyr0oqk
         EQuF3JM2vjXcuTM9dlWERffVcAZ+nRtfVBnn56ZEjQtu2jifqR8Xh8i/tpxatoOEhfo1
         YExg==
X-Gm-Message-State: ACrzQf3OwfiJJqpuQwpnAH069IPkVaaiAAwB9ZADV97q+QKQgC1uARTt
        t+y4qN1DSVbA81B//km8KNulfw==
X-Google-Smtp-Source: AMsMyM4dhHmTVNxe1K5q0OPpxbYaxmEGnV634ItJa0zwjrZNESq53ZU9+CnAuOxxfXQIWgCxMXUa4g==
X-Received: by 2002:a17:903:41cf:b0:183:5a22:c63e with SMTP id u15-20020a17090341cf00b001835a22c63emr4197770ple.61.1666117862254;
        Tue, 18 Oct 2022 11:31:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001708c4ebbaesm8763339plg.309.2022.10.18.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:31:01 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:31:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 0/9] integrity: Move hooks into LSM
Message-ID: <202210181130.AF944615@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <0a8f21a6-02de-36f0-7613-06ed3daf934b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a8f21a6-02de-36f0-7613-06ed3daf934b@digikod.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 05:31:59PM +0200, Mickaël Salaün wrote:
> There is a complementary patch series that didn't received review:
> https://lore.kernel.org/all/20210427113732.471066-1-roberto.sassu@huawei.com/

Yeah, this looks interesting! I hope Mimi or other integrity folks can
review these.

-- 
Kees Cook
