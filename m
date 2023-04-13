Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801046E040C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDMCTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDMCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:19:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3859F10FA;
        Wed, 12 Apr 2023 19:19:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kh6so11931855plb.0;
        Wed, 12 Apr 2023 19:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681352358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AoNmsypXyoGXGjxp2QCOVLgkPqEcooZxqGiyUVMKORY=;
        b=rtdAp8pUT1xeg+sHdseeSi2PZY0w0SeedN1oAzlwW5ZUu/Fkk7aztNCQIC7GGRORFv
         bsF6FJKfM5iHaAP7mGZ3+dnt1Hg4I5NkOf03Yfv2JfUAN5/eAHHkuvI0wBnH/Cl51H5i
         inNYkFkw70g6f7DhVtyQ8LgvcShxD7gl5qfKiY/mEAVDOHF7hv91KM/UhfkJaU6jNuW/
         Uu2WGdzqmZUMTkXbnAKo/u/Pq1TUNAYNTj6Z8t13eHtYIPCIsH8qf0zFhyxwkUJqv7Hu
         v4hFWeO5/dOk7cW6B3qxtLq8f4cen3yHq+6RaGsafxB3h6ykTB4p4qVG4b7iFx5CHUPA
         fw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681352358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoNmsypXyoGXGjxp2QCOVLgkPqEcooZxqGiyUVMKORY=;
        b=SvkAHlo3yeXKYyWc/mzxJqOknlHU9ViHOTsjqMPVVohpLsQg4NA1ynGd01mSpWuLAu
         TdF/KMRIr0Oy0tcJ7+6j3an7bCW9bcoFhPGd9TCaYIY72PsF2o834BUlf8EOP9i6mCvS
         icDLEXlHI7SHsBbhiJWt+/Q0tHPfS0MbO1aqSPyqJgFMsPvVez6JASFNsyWfjqUmIo+x
         gTEqKVBfIVsC8lNuEoOBR3yViEpmBI/U8mKonA4uDh4YwxsARMBOftdLu/yWbumFpOjU
         mIlps342+2d9DmR1yv6P/qX10TT2Ovcl0TCdLdHRNS+wbiBGqZMBs9tYNAGxqh4YRzQx
         yubQ==
X-Gm-Message-State: AAQBX9etqyQVE/sdV0OVrLap2wivk1tVfvsa6d8u2nHTF109V3AzxdeZ
        327QsJbnk/Py1sZIAo2UtHmF62hGpA+z4g==
X-Google-Smtp-Source: AKy350YgBaYDqEgM2C+hmFCOpT123hc0nY43RIYnzC6A630tQkk4BC4RLyqpIAO9bCFs69jp7CRlAw==
X-Received: by 2002:a17:902:d54a:b0:1a6:5fa2:aa50 with SMTP id z10-20020a170902d54a00b001a65fa2aa50mr597498plf.1.1681352358584;
        Wed, 12 Apr 2023 19:19:18 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b0019edc1b9eb2sm235003plj.238.2023.04.12.19.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 19:19:18 -0700 (PDT)
Message-ID: <4b17c67c-4b3d-4326-37e7-949a08d03f55@gmail.com>
Date:   Thu, 13 Apr 2023 09:19:12 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] docs: trace: Fix typo in ftrace.rst
To:     Lin Yu Chen <starpt.official@gmail.com>, corbet@lwn.net
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230412183739.89894-1-starpt.official@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230412183739.89894-1-starpt.official@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 01:37, Lin Yu Chen wrote:
> There is a typo in the sentence "A kernel developer must be
> conscience ...". The word conscience should be conscious.
> This patch fixes it.
> 

Please don't say "This patch does foo".
 
> -waste it in functions. A kernel developer must be conscience of
> +waste it in functions. A kernel developer must be conscious of

Alternatively, what about "aware of"?

-- 
An old man doll... just what I always wanted! - Clara

