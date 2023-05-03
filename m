Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2436F4ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjECCcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjECCcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:32:39 -0400
X-Greylist: delayed 292 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 19:32:37 PDT
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD5273A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:32:37 -0700 (PDT)
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3430sKU3031288
        for <linux-kernel@vger.kernel.org>; Tue, 2 May 2023 22:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=20180315;
 bh=l+Bn2nkMpuhSmnNKAbWRfREFiQ9EAb033dHO+OxbTcA=;
 b=aRXSO8suZ27stxath8gkhd5iNXkgR8SiqAgBhADw6KlQ6rEsAm9I7Qd+K4fTZFujTOZl
 5CLcCsLTMDhjuVVJ0Ri1sc5tStvycQbrUoXe1f4S+1ANbkqi3J4VJnp+Gu2Y7cHcXJ4V
 amofC/9GCXzk6uliOUcJco97Q8oHyPWI5uDCJIV+aYU0zbRu8rOb/+SQ3X5LzGbxLCHI
 m/kCyraW+mvSG6VbwK4JiaOOLi3+wnNzg7gRdBn7DZ1vkz58H829ACJqcCCn7oBYATLa
 B/MfMIpF4PfVS5um1iy56FxSNmeQm93tX5dvDw/k7NcDRTszZfwW/UJKEUQrWiu/iBjZ Pg== 
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3qb8xdc29t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 22:27:44 -0400
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso1471487276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 19:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683080864; x=1685672864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+Bn2nkMpuhSmnNKAbWRfREFiQ9EAb033dHO+OxbTcA=;
        b=XbZrNZGVmlIPuZIIxhJgHvJfTuf9dvyU11738ltmF2C41ixh7N4/wH8s28fQYlPWOS
         EW0bmdZLtAvrUw1yXM/fEXhCXlP2WkoNYZJBnR1YLmbl7Qk7XQ5xLkKyUzwe0zPXcoir
         8CsaRz2OWEbk3Hejopm2Hp3ut+/a9PpnTA81uVjhgtmO9lSxsxcadH04U6nJS4uL0JST
         jjk95Ht6v4IKPH1p73ez7nUBL0NfKAU7Bl310M/e8onwOCdLIXwTJUgOy+FhLKCEKJab
         /rhY96mrn00vc/CNGXaQ7jQDQW2EOQi6ri8b+3o6uTovOwVra6JK2WCrAL/YdCi6jurp
         fsCA==
X-Gm-Message-State: AC+VfDxizt+WTAOJXPcHcfLpmLcjwaqUtNUW9IU6hG8D+bDz74XTPzK+
        YtXdLZIw6yFok8eucgPsUkG4r9TUUsuZi9z/QlDr3OiKH0CrgkWirqluHJuxYaLRsKpHFXT9u6W
        y9iNHEqQPIA1Kt0B0hmcFZr1t+KPQTOCo2/Xp42g=
X-Received: by 2002:a25:1589:0:b0:b9e:6d19:306a with SMTP id 131-20020a251589000000b00b9e6d19306amr720913ybv.16.1683080863728;
        Tue, 02 May 2023 19:27:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nSdJ4vtc+2UclyuNh0+gY80V3U5o6WdNawveEVX91KYB4qQv+i0K+0gnFobH2ZIU67GOgWsA1q0uY80FI4TU=
X-Received: by 2002:a25:1589:0:b0:b9e:6d19:306a with SMTP id
 131-20020a251589000000b00b9e6d19306amr720903ybv.16.1683080863438; Tue, 02 May
 2023 19:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230502203135.24794-1-jinli.xiao@nyu.edu> <CAP-5=fV-RZGwcM8+dMCsqwK_1aFERrvQ1sLJfUCA+kBFMEdoDw@mail.gmail.com>
In-Reply-To: <CAP-5=fV-RZGwcM8+dMCsqwK_1aFERrvQ1sLJfUCA+kBFMEdoDw@mail.gmail.com>
From:   Jinli Xiao <jinli.xiao@nyu.edu>
Date:   Tue, 2 May 2023 22:27:32 -0400
Message-ID: <CAExMFzgmcQqnVSBj9+YVr2UAkUg8CHdpLjQJF6CuOaWdcMbqDQ@mail.gmail.com>
Subject: Re: [PATCH] perf python: Set error messages on call failure
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7rOfd-M4eMXGHUo_KJ4VM8oIp9u3XT4Y
X-Proofpoint-ORIG-GUID: 7rOfd-M4eMXGHUo_KJ4VM8oIp9u3XT4Y
X-Orig-IP: 209.85.219.197
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 clxscore=1015
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the prompt response!

On Tue, May 2, 2023 at 4:37=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Nice! Would it be possible to test this? We could do a shell test

All my changes in this patch is just setting the error message that
can be interpreted by Python just before the bindings return.

I am not sure about shell test, but I can do something like

[root@nyu-lexis linux]# export PYTHONPATH=3D~jinli/linux/tools/perf/python/
[root@nyu-lexis linux]# python3
Python 3.11.2 (main, Feb  8 2023, 00:00:00) [GCC 12.2.1 20221121 (Red
Hat 12.2.1-4)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import perf
>>> thread_map =3D perf.thread_map(9999)   # a non-existent pid in /proc
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
FileNotFoundError: [Errno 2] No such file or directory

whereas the original output is

>>> thread_map =3D perf.thread_map(9999)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
SystemError: <class 'perf.thread_map'> returned NULL without setting
an exception

Upon testing I did find some of the changes unnecessary. I will submit
a new patch to this.

This is my first time contributing so please let me know if I did
anything wrong :)

Best wishes,
Jinli
