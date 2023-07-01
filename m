Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7474483D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjGAJcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 05:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 05:32:27 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2692A1986;
        Sat,  1 Jul 2023 02:32:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 51D2F5C01F0;
        Sat,  1 Jul 2023 05:32:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 01 Jul 2023 05:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688203941; x=1688290341; bh=lo7eYR8ewIKPv+UuAUfwcsCCKFsoq+XFb7w
        PN/jBldM=; b=h4Rc3qxcgBTX1r3XjUg/VaRzeDGQL422vacBaXvkil0mmfMlFcU
        doz3VXok+jLucgiVAyJ4gr/mUpDNCo2+27rT4QKRDapTAA9nw7pWztd2kKV/O52+
        jW5FqWuxmrzVlFJTK6VjWV33YdImO+dft1ZZ1SoZm1UfPNcNvxPCVBpsHsQ7o++d
        s7KNPa2uY3Gt6wa0gjcOSX+hWEQRgSUot37uAGkpR3vGNwkE4zhC0fyWo8NpYaD+
        5hLwN1Y0GiokMRDoU9gqLLA87KsYBbACqXgOq3ZcuzB/BZ5Cs+wIYY8JDO/o160O
        FRyqQTeJye9kL2/XTN8M0GMS/CACdsJfDWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688203941; x=1688290341; bh=lo7eYR8ewIKPv+UuAUfwcsCCKFsoq+XFb7w
        PN/jBldM=; b=eryE3u+SGeIXh10nR3DkZnWVW6JDEfqfKMYKMzhJVflLxhLuzdc
        M9bvaUdVJEo7BwZS2vEdMRYacu1/j2luy5JmNl5XJWVMYw2dYi1wUEGcS0nHdMen
        S1+m+FORfR75bcG0ODDTEK29HvuXQJDk6Ij9VlCcKx97beeRZwDUssMBkzHjBv6y
        pUFpB2tdmfdr5Oaqtqd4mOUqLRe3GIRV0c3SHLPdo5dO/e9Jev+qHc5REpUVMmVf
        eGwhsjEmj6ydyaJKwgp5tjL/FoYaLMCJkjM+4u2NaQgbXAHkbTM0KkfoEqMi/RyU
        c7m8UcXqSOLmXWK75dUxq3o4RykoudlQuUw==
X-ME-Sender: <xms:pPKfZBnfs4vfQH7YX-l5n0Q_7ss_x5JQOktIFdN7vj_k9LivIlAVrw>
    <xme:pPKfZM2PCLcx0rbTJfb2SM_oHgFqMjG-2OkESJSy3zQhW8D5tjl3Ate---0xEzhmE
    VTkBtXvA4ugEw>
X-ME-Received: <xmr:pPKfZHrAM-7jEyENli0LMMK355sUKb88kBYB2OiYJ52CLZeaE9_UhGe-7e7NIv_Hq_fKR2YYuryKGS_T92aP0iaEpkby8BtOXrVL4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdekgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgfekff
    eifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:pPKfZBn8UWy0KtAD3Co1QF8q1bmQpU_4-w0WINauD6Eb8LsDs5QkYQ>
    <xmx:pPKfZP2QthhSFy1Vrck8zciQ-qhe_Ol-X2zMr3-pUdsfiJS3Y0bbxQ>
    <xmx:pPKfZAumIRzkX72xZ42fKi8-zD2KM7k41AlE70RBTHPkH4ZSXGTgSQ>
    <xmx:pfKfZODN8HKq36sH5v_24e4YtqPk6QEM2RcEArW2hv0fMX6ihLNSLw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Jul 2023 05:32:19 -0400 (EDT)
Date:   Sat, 1 Jul 2023 11:32:12 +0200
From:   Greg KH <greg@kroah.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v2 13/13] perf parse-events: Remove ABORT_ON
Message-ID: <2023070106-unified-gone-f9d6@gregkh>
References: <20230627181030.95608-14-irogers@google.com>
 <ea39aaf0-0314-1780-c1cd-7c3661fa3e7c@web.de>
 <CAP-5=fX+kdRujgNAq8SVkkNwgnB383r38+AEmvon1k01R4X=kg@mail.gmail.com>
 <a3517306-7804-f5cf-6182-ef63b6054647@web.de>
 <CAP-5=fUEa150DYWte2u6M8sejxXXqec_L8GEhVbppJHHq8N5PA@mail.gmail.com>
 <4672c6f8-ef0d-6a36-49be-145629c2eade@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4672c6f8-ef0d-6a36-49be-145629c2eade@web.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 11:00:15AM +0200, Markus Elfring wrote:
> >> Will it become helpful to split the proposed patch into smaller update steps?
> >
> > This is kind of why the series is 13 patches long, I'm not seeing why
> > you think the following stats qualify as "long":
> 
> It seems that we came along different expectations for a desirable change granularity.
> Intentions influence how known “code problems” can be adjusted (also for this update step).
> 
> How should following change ideas be handled then?
> 
> 1. Deletion of the macro “ABORT_ON”
> 
> 2. Addition of a comment for a special check
> 
> 3. Introduction of another error message for one failure mode
> 
> 
> Would you like to adjust the change description another bit?

Please no, it's fine.
