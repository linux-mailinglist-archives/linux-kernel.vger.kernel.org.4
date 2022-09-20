Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7275BEC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiITRu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiITRuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:50:37 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5517268A;
        Tue, 20 Sep 2022 10:50:10 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id d64so1697106oia.9;
        Tue, 20 Sep 2022 10:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dEq3miA90nnhWePTqwceDKZJGT2lKqCEv5HRnWi6sM4=;
        b=p7HhJ5eKdu3AyvajqBcQMA8w0MydGVY/0N5lNOeIP9z70cjL8DxIK2O3yPmOobkAVk
         6BBGwfH2XM6CtLGOZGUwF/qWYgnkqb7jq87v2sThdUF3YDIwlj3ITARq42XUYTwFmS9S
         tKMblmAE5EDqzWspumTag5eXn0V7gQcoM61ep0gU97INQGKt4qP2HU9tZF1tcP7UbPCa
         Vy7Dx6oc+t9h3E+5c2gnx4yl7FE0dwqqK/XDkD0OXpEM1WJu+mRtK56BC5XjEPkujILV
         BGUJ2VQy6Sg0VlBp7gHI1s0KKT31j+y3UsirGY+WsQmEI+Q64DeyEedZKAuEt5VJ3V24
         KU+A==
X-Gm-Message-State: ACrzQf0XUGM5CRWSA6q6nRrt34g5nAoV/Cu5dHOsVvAWDQ/zYUcuR+Co
        q0nAK2/qfagXBNSSKjt/lMJh+CWUGSAMiGdND/o=
X-Google-Smtp-Source: AMsMyM7XyOmptTlhO200qzK2yey2JR2OAbI+uPoYgS7BIVM22Sd1S+5GSNLtH6vASn6Dd1bBM+t1AjmN1Eft/rlFhqA=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr2179916oib.218.1663696200257; Tue, 20
 Sep 2022 10:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220916175902.1155177-1-namhyung@kernel.org> <20220916175902.1155177-2-namhyung@kernel.org>
 <bf8988d7-2fd7-fa5d-25ff-2b439f1c0649@intel.com>
In-Reply-To: <bf8988d7-2fd7-fa5d-25ff-2b439f1c0649@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Sep 2022 10:49:49 -0700
Message-ID: <CAM9d7cj8hs37+V4pVzLm-PL8A7ZnvnTMcXpVHg6CvKYXOjO3OA@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf tools: Move dsos functions to util/dsos.c
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Sep 20, 2022 at 6:51 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/09/22 20:58, Namhyung Kim wrote:
>
> Maybe say why the move.

Sure, I'll add something like this.

"The dsos routines will be used in other places soon.  As they have a
separate file already, let's move them to a proper place."


Thanks for your review!
Namhyung
