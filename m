Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE6D5F4BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiJDWKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiJDWJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:09:13 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91662A268
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:09:11 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a17so7027375ilq.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 15:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=+Ut+ygtF7Ls05RPBcrBIKQ5l2ovsencduJorwqHKi78=;
        b=dk9O4Ua0z/Ymv4NFCIScpNCylhY8HPyUArZ6xYnUH9N0Om0DlRxXG444fGdQ3GBzqi
         /LSjbSqPRQFaRXa0lt2kOh3EAaCfT1TkmLIr+lDecLOep8eLqqO/x9+on4kieH84cyS3
         vqFcQGiLSnZDgqD+dIQnfuCvG9yX4IIG4ho4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=+Ut+ygtF7Ls05RPBcrBIKQ5l2ovsencduJorwqHKi78=;
        b=70Ilhvewr3FsTo9gcXN4DhFgGLXsrIGlXLkvFVbkcrolVr89WpQ79QPC6QQtdvs0al
         Cm1hf8fxeDKQim0L9NyFzVVvREO0EJz8CeQitFYES41JPEmjlajuzOzEn0iQXUT9l7Kd
         UJ6IdD13Voio1oPiwVjwVHrwGBPyDlenRHRBDfcHSdM3QjqBPd5lMURlf+t7fGkfrW6q
         jpDeNwdZzAsSNfrmuw9DCFUkNF3QxTYXYmu3HZ34QAxp5MVJAHn4HDoW5PQQAVATaWlv
         alnW5/30jy7FPUt3blIvUpLwwvL6FjMRa7cl9p3vnW9GJ5OPe4gemvIloaAt1Z0uHls6
         JyXw==
X-Gm-Message-State: ACrzQf29fXUw8ps5aOXGuTlOEJNfilWqB8Y/f79oWz+Cdgb0i/egbyMv
        v8ftf+i5JXmMchjBpXTj+bUIvzcD02xsCQ==
X-Google-Smtp-Source: AMsMyM6jUopmQhBlvI+aIXGHb5VnlFnB97ziRF+3b4h8XWQwD5x8HTcPaJLlhVLvb5O3MXk42QJVGw==
X-Received: by 2002:a05:6e02:1a8c:b0:2f6:4364:345f with SMTP id k12-20020a056e021a8c00b002f64364345fmr12887648ilv.242.1664921350895;
        Tue, 04 Oct 2022 15:09:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y16-20020a056602049000b006a0d1a30684sm6125777iov.33.2022.10.04.15.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 15:09:10 -0700 (PDT)
Message-ID: <57a492fb-928b-9e0a-5f0e-dc95ef599309@linuxfoundation.org>
Date:   Tue, 4 Oct 2022 16:09:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     "conduct@kernel.org" <conduct@kernel.org>,
        tech-board <tech-board@lists.linux-foundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux Kernel Code of Conduct Committee: September 30, 2022
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Code of Conduct Committee: September 30, 2022

In the period of April 1, 2022 through September 30, 2022, the Code of
Conduct Committee received the following reports:

Unacceptable behavior or comments in email: 1

The result of the investigation:
   - Resolved with a public apology from the violator with a
     commitment from them to abide by the Code of Conduct in
     the future.

We would like to thank the Linux kernel community members who have
supported the adoption of the Code of Conduct and who continue to
uphold the professional standards of our community. If you have
questions about this report, please write to <conduct@kernel.org>.
--------------------------------------------------------------------

This report and the past Code Of Conduct Committee reports
can be found on the Code of Conduct website at

https://www.kernel.org/code-of-conduct.html

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)
