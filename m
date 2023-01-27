Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C918467EDBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjA0Snx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjA0Snv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:43:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1652D20042
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:43:49 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6AFD83FFEE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674845027;
        bh=XiDfwrtQmIYCUcD8u3S8ChFouAMc6g+DcNufJxicUgQ=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=SMQxRgtDUDT6lEFvGQ/bqoFPvdfpQqsBubRf+/6wrGb75HDpyHByU70yUXLJW82tQ
         aBcl9G99kDh7bR5VyWnkczB6JlSr+lYidDQaP1jXdjqTH9Ctg6qKy+fPiT+Yb8c7as
         ITysOBOG/CUj95zBy8DAclibKQKQANdtAlbTMnoLFOW5VpkYwebRrKG8tw/y0Ca+x0
         xvGVuE/Q1yD+0HfDgbCViv7PQRXFd1bkyiD3jQXU8N/aBAg++1nv2M4p/yxnBZ6x4A
         BGknw2mYADJ0KtbBclV5diI5Ayg9XJXHBMdYx15wnztCHhcyB+6Qw3gLUpJALjO3ql
         +/bNR5Di1czGw==
Received: by mail-wm1-f70.google.com with SMTP id bg32-20020a05600c3ca000b003dc0df8c77dso1779082wmb.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiDfwrtQmIYCUcD8u3S8ChFouAMc6g+DcNufJxicUgQ=;
        b=2+38WC8XhYoaXnzsSRbqPC8q/nTR2PY5FiUFsG5Jc4O3BOErwHe98YhOY/c4n/hkQ5
         bpnjdVd9thJW+MfCW5E7tBCBkZRGZ0Pdjg8B3zkIB1ybJSSwCNSISamfumGyFmDt07Jm
         GCc0dNZEMm6FZU9Y56KCNoB9+O9gH6Zf6FDsjM3VUPEzmBCwKwDjvesXIAgBijP28/W9
         RIVAU8/6laqNtMDOOYIEdVub6whyRsF/+fe7+TXMVETbnliu/0seyJgjyPShBlHEkcSH
         SoJ8ioyhhtMcYuDDQThcn+KqgUEE8YPUuoqGgfig0C6XS57juqRUO+9Z/n3mNi2epZOx
         JtPw==
X-Gm-Message-State: AFqh2kqmO+jID2bKv3iz+w9Lw19Ut7NFUjjpT9vvY2PpT/eTOeDOhiiA
        GZQ/zTdQMQwJ/8wNLtWK4u0vu1VNSeuyZrJNMR0S0MNoxOT3SON5CZ3GB+rzpXuj+L+1sj2Frdu
        1Xs9SXoN5UI4DUjJ6HTEcsxdDSHoULxFoWOsoUH7cZA==
X-Received: by 2002:a1c:cc11:0:b0:3da:1d52:26b5 with SMTP id h17-20020a1ccc11000000b003da1d5226b5mr47883409wmb.14.1674845025460;
        Fri, 27 Jan 2023 10:43:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvC8ImX3BIkyIZQCXDWeCNeGIA82L5yixhvXk4MqP+UfuRQRKikf7sEdocNH//sSFtPcMkd4A==
X-Received: by 2002:a1c:cc11:0:b0:3da:1d52:26b5 with SMTP id h17-20020a1ccc11000000b003da1d5226b5mr47883392wmb.14.1674845025235;
        Fri, 27 Jan 2023 10:43:45 -0800 (PST)
Received: from qwirkle ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c424300b003dc3b188411sm2271302wmm.36.2023.01.27.10.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:43:44 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:43:42 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Lina Wang <lina.wang@mediatek.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests: net: Fix udpgro_frglist.sh shellcheck
 warnings and errors
Message-ID: <Y9QbXuMOV3BWSzt5@qwirkle>
References: <20230127140944.265135-1-andrei.gherzan@canonical.com>
 <20230127140944.265135-3-andrei.gherzan@canonical.com>
 <CANP3RGchqLRLRAxgWU69DzWfa9R2d0AhgeBdpJhmaE+c-Sszjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGchqLRLRAxgWU69DzWfa9R2d0AhgeBdpJhmaE+c-Sszjw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/27 06:32AM, Maciej Żenczykowski wrote:
> On Fri, Jan 27, 2023 at 6:09 AM Andrei Gherzan
> <andrei.gherzan@canonical.com> wrote:
> >
> > This change fixes the following shellcheck warnings and errors:
> >
> > * SC2155 (warning): Declare and assign separately to avoid masking return
> >   values.
> > * SC2124 (warning): Assigning an array to a string! Assign as array, or use
> >   instead of @ to concatenate.
> > * SC2034 (warning): ipv4_args appears unused. Verify use (or export if used
> >   externally).
> > * SC2242 (error): Can only exit with status 0-255. Other data should be
> >   written to stdout/stderr.
> > * SC2068 (error): Double quote array expansions to avoid re-splitting
> >   elements.
> >
> > Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-tests")
> > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> > ---
> >  tools/testing/selftests/net/udpgro_frglist.sh | 20 +++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
> > index e1ca49de2491..97bf20e9afd8 100755
> > --- a/tools/testing/selftests/net/udpgro_frglist.sh
> > +++ b/tools/testing/selftests/net/udpgro_frglist.sh
> > @@ -3,7 +3,8 @@
> >  #
> >  # Run a series of udpgro benchmarks
> >
> > -readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
> > +PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
> > +readonly PEER_NS
> >
> >  BPF_FILE="../bpf/xdp_dummy.bpf.o"
> >  BPF_NAT6TO4_FILE="nat6to4.o"
> > @@ -19,7 +20,7 @@ trap cleanup EXIT
> >
> >  run_one() {
> >         # use 'rx' as separator between sender args and receiver args
> > -       local -r all="$@"
> > +       local -r all="$*"
> 
> this should technically use arrays, something like
> 
> local -a -r args=("$@")
> 
> but perhaps just get rid of args and just use "$@" directly below

Using it directly would not work with the substitutions later because it
would try to apply it to each positional parameter in turn. Same when
using an intermediate array.

> 
> >         local -r tx_args=${all%rx*}
> >         local rx_args=${all#*rx}
> >
> > @@ -56,13 +57,13 @@ run_one() {
> >  }
> >
> >  run_in_netns() {
> > -       local -r args=$@
> > +       local -r args="$*"
> >    echo ${args}
> >         ./in_netns.sh $0 __subprocess ${args}
> 
> ie. here could just use "$@" directly twice instead of defining args.
> $0 should be doublequoted - though I guess it'll never be empty, and
> is unlikely to include spaces.

That sounds fine to me. I'll include it in v4.

> >  }
> >
> >  run_udp() {
> > -       local -r args=$@
> > +       local -r args="$*"
> >
> >         echo "udp gso - over veth touching data"
> >         run_in_netns ${args} -u -S 0 rx -4 -v
> > @@ -72,7 +73,7 @@ run_udp() {
> >  }
> >
> >  run_tcp() {
> > -       local -r args=$@
> > +       local -r args="$*"
> >
> >         echo "tcp - over veth touching data"
> >         run_in_netns ${args} -t rx -4 -t
> > @@ -80,7 +81,6 @@ run_tcp() {
> >
> >  run_all() {
> >         local -r core_args="-l 4"
> 
> is this still useful? embed directly in ipv6_args
> 
> > -       local -r ipv4_args="${core_args} -4  -D 192.168.1.1"
> 
> perhaps this should stay as a comment??

Well the way I see it is one or the other. We either embed and drop
ipv4_args or keep ipv4_args as a comment but also core_args. I'll do the
former in v4 if no other objections.

> 
> >         local -r ipv6_args="${core_args} -6  -D 2001:db8::1"
> >
> >         echo "ipv6"
> > @@ -90,19 +90,19 @@ run_all() {
> >
> >  if [ ! -f ${BPF_FILE} ]; then
> 
> double quote
> "${BPF_FILE}"
> in case space in file name

This change only targets warning/error issues. There are way more "info"
ones, but I didn't want to splash a big patch for all those.

> 
> >         echo "Missing ${BPF_FILE}. Build bpf selftest first"
> > -       exit -1
> > +       exit 1
> >  fi
> >
> >  if [ ! -f "$BPF_NAT6TO4_FILE" ]; then
> 
> there seems to be inconsistency around [ vs [[, use [[ if relying on bash anyway



> 
> >         echo "Missing nat6to4 helper. Build bpf nat6to4.o selftest first"
> > -       exit -1
> > +       exit 1
> >  fi
> >
> >  if [[ $# -eq 0 ]]; then
> >         run_all
> >  elif [[ $1 == "__subprocess" ]]; then
> 
> while this does indeed work, imho $1 should be "$1" to be less confusing

Agreed and again, there are a good set of other places where this is
needed. Should I just address them all in an extra patch? Again, this
one only scoped warnings/errors to avoid impact.

Thanks for the review.

-- 
Andrei Gherzan
