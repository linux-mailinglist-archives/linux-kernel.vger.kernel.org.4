Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCEC65F9C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjAFC5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjAFC5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:57:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E734D6E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:57:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so2722106wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 18:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYnNol7tL6eujVJoPtHckFJLhOe/TlWL/0mv/fSdxbg=;
        b=C4lqjpAnQXvwBwYmYF4V09tS/y3AQmmfmB+lQfenhOfbw71Tju+O1ssve3v2W5sgOn
         Z1xhTMHcTRQOBT3NCMrjIGk0XuR3BsVNSvhuPsm7vndUDVfnVJ+UW48Lfbs3nXQTrBPT
         MztAoXFks6grnIlAAxlmO+ZVyMWr91I5JEbA91P08RW3pd4i6KGRxAOt+4pNAON2FXn+
         3xNdqzx9Tkh1p+zRB6N/xquvC108BDDSYR7Z+l/9JdSydHnqp38a26jv/EohEOc+gGdC
         hKztTrHN02zeoeg/rbvZXw10k3aOFnd0Lf9Ad9mg1maqI5lhujY2a3UerxUMKzbtQWOL
         7SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYnNol7tL6eujVJoPtHckFJLhOe/TlWL/0mv/fSdxbg=;
        b=R1h8q2qt5LsZqtuP+TxbloEY4C/xeVdLk4gGGZUEAYKss2HSZYZYZkNfGL5oe6T1W+
         dq3yyNOMlqzvqKZ9gx8XmHvkbQeHgmSLQB681D3FvDfDNnP05tlkG3rTD3c2UjVUru1j
         6TGT92RscRFQlwHzQAwcoLF0r9uzRVsTrPduQV3yXSmirn4aVKsSay+xBREH4hUphu0g
         XVBv4QmorrOPBk/50NjETnfMjcIhiwi5aod6ke/HC5Sv8pVmeRz2KBOubKQQ1iy2ffZO
         cP/HQC7r5qB/69HYNFFvyl7VkSGS7n/KChr3ndt1Q05XpI+eBwO9/JwlxoEAZBGG7/ju
         YQWw==
X-Gm-Message-State: AFqh2kpWF+aqwWFhrwMq9ZnE2JVeS9ovZCKmJNVCe47yc8iZbg/dTViT
        /17+bC+NxKfEfQRnIUdTRAmrrTdrWaTCOIry/XAfUQ==
X-Google-Smtp-Source: AMrXdXubsV9SEgC7wXRqKqXtE6ieEZkLu8z0ZvO+WbUI2V/Tvi9MMJu1FXJzCCIYSqogdWKI9fTNtC6QYRZWMYcL4HM=
X-Received: by 2002:a05:600c:44d4:b0:3d1:fd95:a8f6 with SMTP id
 f20-20020a05600c44d400b003d1fd95a8f6mr2772408wmo.189.1672973857619; Thu, 05
 Jan 2023 18:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20230105100014.1935-1-cuiyunhui@bytedance.com> <a8540626a36339bbac8603559b9200a08e4de9ed.camel@redhat.com>
In-Reply-To: <a8540626a36339bbac8603559b9200a08e4de9ed.camel@redhat.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Fri, 6 Jan 2023 10:57:26 +0800
Message-ID: <CAEEQ3wkD5bX34J36-OJ7WdHX=Y9hwFuoCtZ6_zyngKYrz3y1wQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] sock: add tracepoint for send recv length
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, duanxiongchun@bytedance.com,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 8:03 PM Paolo Abeni <pabeni@redhat.com> wrote:

> > We can obtain the information with kretprobe, but as we know, kprobe ge=
ts
> > the result by trappig in an exception, which loses performance compared
> > to tracepoint. We did a test for performance comparison. The results ar=
e
> > as follows. Time per request, sock_sendmsg(k,kr):  12.382ms,
> > tcp_send_length(tracepoint): 11.887ms=EF=BC=8Cwithout hook=EF=BC=9A11.2=
22ms
>
> 12 ms per packet? I hope there is a an error in the unit of
> measurement.
>
> I'm unsure the delta wrt kreprobe justifies this change.
>
> In any case you need to include the netdev ML into the recipients list,
> and even Cong Wang, as he provided feedback on v1.
>
> Thanks,
>
> Paolo
>

I will add the record of testing with the tool to the commit log of
v3, and then send the email to netdev ML and CongWang, thank you.
