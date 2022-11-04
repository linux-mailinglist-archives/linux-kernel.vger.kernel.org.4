Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC90961A3EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiKDWJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiKDWJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:09:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D82EF45
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:09:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t25so16684755ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9KBg06ASwQ0kj5Ll8CLNORO/tXAtWH1/P4+spInuBjU=;
        b=6wG3u3hZVFCLp3K2T2Sf/LAU1DSBeN+nC0BGK9arw6vilmy9jI48rpAMcDoCZpwFKG
         QpolMLRk+09tudrxWMG2TE2c7/b5KNs97QRcf0ry42QDBSAbC9J6askQdS0xNj1LjsU0
         ccJ1m2byPOfKcgqa5CBqRuYVt0QTgrd3Z4HRcZckMcck45/mLoNpTISwLEJ2dAWw0ypt
         NWBRISB89SQ4S9QG61smvRzvIdZYXLsAssVf/IMRe1gBRxSr6Pf4fFi9W177ptwXDOTQ
         NiOLgd/XsSZFsnEekAt3ShFwhLgA2Zo1k5VJj655qT5UiiSSeF4xInIo3CB6jdkq9tNn
         pmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KBg06ASwQ0kj5Ll8CLNORO/tXAtWH1/P4+spInuBjU=;
        b=ZoVYGUs6niP7E2L+k/PLCJks5WleYwyluJoXr1OS6m20Hw+lvM0wIpL02zFQi9TPn5
         W0EEiyarUkAFIOvSZINpOSvgdYcKti7nkxEpZ407zlC60dajopnqQ1iEOwmHJuiRIv33
         nYOTNz/zHNvmbqebl1ClXVpXA4CbbRkzADWaQojYuNK25By6ay3VF1lpfwYBhIQ3g0HH
         FP1mQyp1MPlNH4BWz5WqHfzG4kYML7LD99+Y2Js9hGGBqUfQxNSv+FrXYe5FocDpZzcB
         Qc02R0qsDFyt+aihY66oMtDcz/F/CdbCkFeTbdZRzaF4LYISt9wdUzkE9AbwW9mxhJON
         SRWA==
X-Gm-Message-State: ACrzQf2SaR9qlvh8JjcCQP47sLAAyPg+YpDF5UQubeetScCcd6ZH2gXe
        K9DrFZr2yyDg3DA7DTxphIlSnMF83qZKN+dXhGj8jQ==
X-Google-Smtp-Source: AMsMyM6zLjfIm1LJZmdJmX3F1xuORskdHrN+sT3pubY7G2c3YSxmJcX5MMdRtWEU53NiZRQBAb55waQpcSVm/whAGAo=
X-Received: by 2002:a17:907:6e9e:b0:78c:5533:4158 with SMTP id
 sh30-20020a1709076e9e00b0078c55334158mr34265173ejc.417.1667599783015; Fri, 04
 Nov 2022 15:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221103205010.3266865-1-joe@isovalent.com> <101ab00c-5fa7-c3ee-63bd-f235e7c4d398@gmail.com>
In-Reply-To: <101ab00c-5fa7-c3ee-63bd-f235e7c4d398@gmail.com>
From:   Joe Stringer <joe@isovalent.com>
Date:   Fri, 4 Nov 2022 15:09:32 -0700
Message-ID: <CADa=RyxodgJ+Wa3tiWxTntZoy7eSm_UkuzDBx9tCN=s_QnsDOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: Add LRU internals description and graph
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending, this time without HTML.

On Fri, Nov 4, 2022 at 2:31 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 11/4/22 03:50, Joe Stringer wrote:
> > +An LRU hashmap type consists of two properties: Firstly, it is a hash map and
> > +hence is indexable by key for constant time lookups. Secondly, when at map
> > +capacity, map updates will trigger eviction of old entries based on the age of
> > +the elements in a set of lists. Each of these properties may be either global
> > +or per-CPU, depending on the map type and flags used to create the map:
> > +
> > +.. flat-table:: Comparison of map properties by map type (x-axis) and flags
> > +   (y-axis)
> > +
> > +   * -
> > +     - ``BPF_MAP_TYPE_LRU_HASH``
> > +     - ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
> > +
> > +   * - ``BPF_NO_COMMON_LRU``
> > +     - Per-CPU LRU, global map
> > +     - Per-CPU LRU, per-cpu map
> > +
> > +   * - ``!BPF_NO_COMMON_LRU``
> > +     - Global LRU, global map
> > +     - Global LRU, per-cpu map
> > +
>
> Shouldn't the table be written in reST table syntax instead?

This table follows the syntax outlined in
https://docs.kernel.org/doc-guide/sphinx.html#list-tables . Is that
document not up to date?
I'm happy to do this, but several of the diagram boxes will reference
terms like rotation, shrinking etc without explaining what they are. I
think it's a net negative to readability if this text is not included
with the diagram. If you think the commit formatting is a bit over the
top, I could maybe just remove the decoration and embed the content
directly in the doc? On my first attempt at sketching this up, it just
felt a bit weird for me to submit that text directly if Martin was the
author of the text. But I could figure something out for that if
that's the preferred approach.

> > +Notably, there are various steps that the update algorithm attempts in order to
> > +enforce the LRU property which have increasing impacts on other CPUs involved
> > +in the operations:
> > +
> > +- Attempt to use CPU-local state to batch operations
> > +- Attempt to fetch free nodes from global lists
> > +- Attempt to pull any node from a global list and remove it from the hashmap
> > +- Attempt to pull any node from any CPU's list and remove it from the hashmap
> > +
>
> Better say "... other CPUs involved in the following operation attempts:"

Will fix, thanks.

> > +Even if an LRU node may be acquired, maps of type ``BPF_MAP_TYPE_LRU_HASH``
> > +may fail to insert the entry into the map if other CPUs are heavily contending
> > +on the global hashmap lock.
> > +
> > +This algorithm is described visually in the following diagram:
> > +
> > +.. kernel-figure::  map_lru_hash_update.dot
> > +   :alt:    Diagram outlining the LRU eviction steps taken during map update
> > +
> > +   LRU hash eviction during map update for ``BPF_MAP_TYPE_LRU_HASH`` and
> > +   variants
> > +
> <snipped>...
> > +
> > +The dot file source for the above diagram is uses internal kernel function
> > +names for the node names in order to make the corresponding logic easier to
> > +find. See ``Documentation/bpf/map_lru_hash_update.dot`` for more details.
>
> Since it references the same figure, just say "See the figure above for more
> details".

The figure is rendered visually in the docs without the corresponding
node names, so developers would need to look at either the dot source
or maybe the SVG source though that's arguably a little less readable.
The suggested phrasing to see the figure doesn't sound very useful to
me since the simple reader's interpretation would be to look directly
at the render rather than the source. This last sentence was intended
as a helpful way for developers to find the path to the corresponding
document, but if you think that is too much detail then I could also
just drop this last sentence. Thoughts?

Cheers,
Joe
