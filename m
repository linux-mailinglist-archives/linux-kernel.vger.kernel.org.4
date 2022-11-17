Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C649F62E327
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiKQReQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKQReN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:34:13 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E91178D64
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:34:12 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-36cbcda2157so25414327b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gnHYZNnUQPhhtm+c6+nXXKTYFwWxWq5yxUS6615HEp4=;
        b=LtzbAWE2mhQFcfcSDhzAra9cfowCswIjObI7qG4BIW5iceajiS/eY3koUUflXTA7O+
         jrXs2/kdSmvKHX56DJK7BBFRmzH3ZkZ9SFRHhuyp49uayPjyvYV2E/iPR+8HyXJoVhxO
         MdjeTCJvu5e2o67UHQo0dcxK1DQMxTZGvrCSpCh3HUgvX3l0wtXN1TjNf0V0sImEZL/2
         y+y35XXuyuXHWp5wAG8/EvHJ+mkLc4qtELo7i64Ue//oMo63utDDufOKpZEw4Y37r3ap
         Izvh6MQqVitbCfdeF4cv2WaGYvjygNa6RXWVEKN7P2SDFMuSAuaHwvpyfLHbmDogtrpN
         4aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnHYZNnUQPhhtm+c6+nXXKTYFwWxWq5yxUS6615HEp4=;
        b=A+yewPgL1KyJOMHemw4y6cy3cAWcZ7EkziObkNPHGi5NgxLxk3TZ/ZqcX+MbQgYFeZ
         1fFZF8TZ+Ug03qvL76bUspD3l/euIc8d4Ya2XN0cRwLKmsbd7Ue1L7+26PkmVIb2Bx/h
         NlvUPmxR5DAJM229m39mQVtbjuR/tnBbnU8AbjP8TBL5pmFEqUF73xXBcpH2suCXYPY0
         Ou8+TWfgFIIbas8LFyYQOEGMFBvVbe+smsIsew+tVt0OVCN6xRoFQaUiSo5OnTeVZL5n
         S0yeqmgvzVJEpi7YgexOj9ENmEnqb4VOxpZQWkNsSmXbezpA9N1SgYKkNumvRLq5tln2
         wLRw==
X-Gm-Message-State: ANoB5pmH6JNS1qrBdMsQ5LIDHJZnCn1jfMGg6hUlN8qWSHwkU5pGUjzM
        6UAHajHbZ/Ck8uFRjVoD0BrIq3c+bgh1dzasrnqmbBTPnr3T7Q==
X-Google-Smtp-Source: AA0mqf6KCLRpFQbK+c5XYubxaIcqESvR9Vv03C7CIPbHJA4qgSSjlWQofuQWVyxkUGAF6iDFg/e60hLM0uLbDIjyDAI=
X-Received: by 2002:a0d:e601:0:b0:356:d0ed:6a79 with SMTP id
 p1-20020a0de601000000b00356d0ed6a79mr2854499ywe.489.1668706451317; Thu, 17
 Nov 2022 09:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20221117031551.1142289-1-joel@joelfernandes.org>
 <20221117031551.1142289-3-joel@joelfernandes.org> <CANn89i+gKVdveEtR9DX15Xr7E9Nn2my6SEEbXTMmxbqtezm2vg@mail.gmail.com>
 <Y3ZaH4C4omQs1OR4@google.com> <CANn89iJRhr8+osviYKVYhcHHk5TnQQD53x87-WG3iTo4YNa0qA@mail.gmail.com>
In-Reply-To: <CANn89iJRhr8+osviYKVYhcHHk5TnQQD53x87-WG3iTo4YNa0qA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 17 Nov 2022 09:33:59 -0800
Message-ID: <CANn89iLSsoS1dT5GzyjV=wBFLjM6BzjXJooWMNQV+ffQvhCrYw@mail.gmail.com>
Subject: Re: [PATCH rcu/dev 3/3] net: Use call_rcu_flush() for dst_destroy_rcu
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com,
        jiejiang@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 9:17 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Nov 17, 2022 at 7:58 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hello Eric,
> >
> > On Wed, Nov 16, 2022 at 07:44:41PM -0800, Eric Dumazet wrote:
> > > On Wed, Nov 16, 2022 at 7:16 PM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > In a networking test on ChromeOS, we find that using the new CONFIG_RCU_LAZY
> > > > causes a networking test to fail in the teardown phase.
> > > >
> > > > The failure happens during: ip netns del <name>
> > >
> > > And ? What happens then next ?
> >
> > The test is doing the 'ip netns del <name>' and then polling for the
> > disappearance of a network interface name for upto 5 seconds. I believe it is
> > using netlink to get a table of interfaces. That polling is timing out.
> >
> > Here is some more details from the test's owner (copy pasting from another
> > bug report):
> > In the cleanup, we remove the netns, and thus will cause the veth pair being
> > removed automatically, so we use a poll to check that if the veth in the root
> > netns still exists to know whether the cleanup is done.
> >
> > Here is a public link to the code that is failing (its in golang):
> > https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/src/chromiumos/tast/local/network/virtualnet/env/env.go;drc=6c2841d6cc3eadd23e07912ec331943ee33d7de8;l=161
> >
> > Here is a public link to the line of code in the actual test leading up to the above
> > path (this is the test that is run:
> > network.RoutingFallthrough.ipv4_only_primary) :
> > https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/src/chromiumos/tast/local/bundles/cros/network/routing_fallthrough.go;drc=8fbf2c53960bc8917a6a01fda5405cad7c17201e;l=52
> >
> > > > Using ftrace, I found the callbacks it was queuing which this series fixes. Use
> > > > call_rcu_flush() to revert to the old behavior. With that, the test passes.
> > >
> > > What is this test about ? What barrier was used to make it not flaky ?
> >
> > I provided the links above, let me know if you have any questions.
> >
> > > Was it depending on some undocumented RCU behavior ?
> >
> > This is a new RCU feature posted here for significant power-savings on
> > battery-powered devices:
> > https://lore.kernel.org/rcu/20221017140726.GG5600@paulmck-ThinkPad-P17-Gen-1/T/#m7a54809b8903b41538850194d67eb34f203c752a
> >
> > There is also an LPC presentation about the same, I can dig the link if you
> > are interested.
> >
> > > Maybe adding a sysctl to force the flush would be better for functional tests ?
> > >
> > > I would rather change the test(s), than adding call_rcu_flush(),
> > > adding merge conflicts to future backports.
> >
> > I am not too sure about that, I think a user might expect the network
> > interface to disappear from the networking tables quickly enough without
> > dealing with barriers or kernel iternals. However, I added the authors of the
> > test to this email in the hopes he can provide is point of views as well.
> >
> > The general approach we are taking with this sort of thing is to use
> > call_rcu_flush() which is basically the same as call_rcu() for systems with
> > CALL_RCU_LAZY=n. You can see some examples of that in the patch series link
> > above. Just to note, CALL_RCU_LAZY depends on CONFIG_RCU_NOCB_CPU so its only
> > Android and ChromeOS that are using it. I am adding Jie to share any input,
> > he is from the networking team and knows this test well.
> >
> >
>
> I do not know what is this RCU_LAZY thing, but IMO this should be opt-in
>
> For instance, only kfree_rcu() should use it.
>
> We can not review hundreds of call_rcu() call sites and decide if
> adding arbitrary delays cou hurt .

At a very minimum, things like rcu_barrier() should make sure that all
'lazy' callbacks are processed in a reasonable amount of time.
