Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E3669CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjAMPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAMPr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:47:58 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CE06CFF4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:39:54 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g4so22772359ybg.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaDbi+LUA8rM4s4XW9JDQGLM+Ps3F0phrc3eSnyqhBY=;
        b=iSgrOTwGrVDn0mm6CW2ExMxlo27NkTjOm6gltw7XEAduc8MmWrwdyP5oFSirHFM7na
         tDgOYu+ecmsaodLCceyNZknOpM4E0E8b/PIAp4fe81fPBxmXgMLA/gbNoROqqEwzcfJE
         BTwQzvU2vCV6zZ3kXdKgUuuVOcIg80UElDUVzA5vBEXiq9s+zPHXKTRCa1aDt4NHU55s
         laTokgZgtPjwSz09mXIXs8UFdqrh8qlZgxyxzzoosddfyIgGRtUzMKUovKKEgEAJNOc5
         Q6fllF6QNdZuODnOfzsXUiIgzvPQr6OybHNq/xdGDvgS43XXSa9BSvNHvGZcYiwGW9Yq
         laoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaDbi+LUA8rM4s4XW9JDQGLM+Ps3F0phrc3eSnyqhBY=;
        b=cR9fMzmUPuveqlXUXdm6Z3HHrWZkXCPpFBNsKMLOJd+sH/45vSpov7FgQYZ3V2B5hp
         XXlQPICZpcjQWjG6GCmC9AjmCFdg2e8W2bnVyeYvt+NJFLfZE/t4KPExUw2skosFlVY5
         hpsb9WabRtA5lxgILi2/x3RPpc9chb1J3bZYw9o2DvLa2dwp5c7aj/PD+oixfveXOgeR
         KVH9zJJagWZm9921Xr7RXof5hw2sbZRFyLOVF/yuqk4h+TT6z+yYXQr7TRtnHH6+/wmG
         wL31Bmb1r6Fi40B5zzsgFO2BM0rQ6D3tJdZaGFFfUPRsVkP8hosgqU9EQfR1vKlIOX9y
         RRIQ==
X-Gm-Message-State: AFqh2kqJfBJx24gMan3yJ2XmRASiEySldZCeW+k8AK+ooCSIyacDq0iS
        bF8Hi0cfhKnRuGcv4oJgNaoKj9uU66rvKlpfCo/mhoMu9oE=
X-Google-Smtp-Source: AMrXdXtkDEN3o3UwVBzp6yL3sLcHm9dXtbZ9Cns1Xc+Wb+mqAkWXr+ZGuW0ulLCufC8UsjQ4fwezcKi3tXy5uSblovo=
X-Received: by 2002:a25:843:0:b0:72c:c005:d76d with SMTP id
 64-20020a250843000000b0072cc005d76dmr7164098ybi.264.1673624394149; Fri, 13
 Jan 2023 07:39:54 -0800 (PST)
MIME-Version: 1.0
Sender: gogoligobana@gmail.com
Received: by 2002:a05:7000:9b41:b0:40f:f613:252b with HTTP; Fri, 13 Jan 2023
 07:39:53 -0800 (PST)
From:   Kayla Manthey <sgtkaylla202@gmail.com>
Date:   Fri, 13 Jan 2023 15:39:53 +0000
X-Google-Sender-Auth: Tu-iIDNzYESmM-RZvP9xv37Wc4w
Message-ID: <CAPURPbi1GPi-UFjqLKviUOaqX-1gxGQXkk7NxLpOAYbYtp9nYQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  dear, please  do  you  get  my  previous message, thank  you.
