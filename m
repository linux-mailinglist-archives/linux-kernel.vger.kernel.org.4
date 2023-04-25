Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D716EE815
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjDYTMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjDYTMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:12:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE017A3F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:12:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-760f040ecccso35636139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682449962; x=1685041962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nm/Z08Qpc4xJ1wGItB99tey8UIwra1lRMlRZ9zrzBPc=;
        b=OiRIavseMauKAEUtXkh7JKfcWJgVJMo2NFL3AlOZoYNSHaSmaKc09/PMTDMcoHdfG1
         Zg+L0Ni6fevfucvuDmaWeEZAazhPqldDSLyNSlDmEuLdydZQ2yy9TUMRcoI1HlilLzYY
         n2AUUDc5wGJ8i7y0v1pvB7c64FY4brgRaS2adob9q1jl2iqW89RTsALIlIlRIMIuq/Ht
         M60IGvHSkgkcSWt/gkYchd+m1xgdbsGQD9UlUC9BXrEkWBThlOpCXzBAlyOOFquk5sIG
         gID0XLPNKeXl7gSIzakIpytEM94g6L04b7KdVIL37AUVSMJoMuOaFBqXZWgOSyfyGfA3
         NGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449962; x=1685041962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm/Z08Qpc4xJ1wGItB99tey8UIwra1lRMlRZ9zrzBPc=;
        b=O9p5ZLfTdG/hX+l5w//HBFv5z9EmEWkZzkNC795UfYydgn2pgRY0/AjXcV2yompx/6
         yBUktIBi2Kif1nVlZRaa7RXMHxDtE+5pKPTkJZzYrdHknmIuwI4hNGJA1PhycKhcz273
         aTa303LSejOBC7lqIjxG8HjH82d2B7oww25c6/lmvQl69C2wkqIolrSbxepZarxVsa4Q
         O0I4cXFZXMqdrI/2pluee5OByQt12nik5qTEe/xoMmMiNFR0o0lOZ2ilh9XDeDBa/ruO
         wRXZifyttG4hKd2UxU9XrVSVkREOQi+uSC8dtAI9OKh7dRsPB4Fty7ePU+vHEFTbMDeW
         cOpA==
X-Gm-Message-State: AAQBX9ceSnEu9vC041fdsCidzeTd6lCDs81Hkqj9XLdDCaMxoHMeeidT
        NbVbbpHaj3B6dfCh+GGGHItnUduNyRiv5XwpDKw=
X-Google-Smtp-Source: AKy350bBFu9+ThvBG9nd8IvRG+SsH1G8UJ7BBrVNqOYtp46eE8WfkBbY1hYEANxLctC3005MdoF+mA==
X-Received: by 2002:a05:6602:1555:b0:763:6aab:9f3e with SMTP id h21-20020a056602155500b007636aab9f3emr14566464iow.1.1682449962549;
        Tue, 25 Apr 2023 12:12:42 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u11-20020a02230b000000b00411a1373aa5sm3304560jau.155.2023.04.25.12.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:12:37 -0700 (PDT)
Message-ID: <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
Date:   Tue, 25 Apr 2023 13:12:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
To:     Junxiao Bi <junxiao.bi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org
Cc:     paul@paul-moore.com, nathanl@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, konrad.wilk@oracle.com, joe.jin@oracle.com
References: <20230420215331.88326-1-junxiao.bi@oracle.com>
 <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 11:55?AM, Junxiao Bi wrote:
> Any IO folks can help review this patch?
> 
> Paul needs a confirm from you that the information blktrace exporting
> to userspace through the relay files are safe, not leaking information
> that userspace shouldn't know in lockdown mode.

I don't know anything about what lockdown is, but in terms of blktrace,
it is a way to trace meta data associated with IO. It'll tell you things
like "task T wants to {read,write} on device D, at offset X, and of size
Y". For passthrough IO, it'll also dump the CDB. There's never any
actual data traced.

-- 
Jens Axboe

