Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912786D6828
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjDDQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjDDQCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:02:01 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DC1717
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:02:00 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j2so10319463ila.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680624120; x=1683216120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=curhK01sXfmE2RlMU8WuYjmrkMgBz4YATpsIYnecl9s=;
        b=Voe6H8asBoDcHT+e20k3gQeZBAWjN9nGktg6hvKLxI7qZX/w7TTjQ4c76fxR6H0kdr
         l9XoSO3IVCeqx3/+Tdho7vggVvzo2WZ6NREw5t3K6LsZYymclNs7cDf7wYpBNC2qE3Dy
         h0aB65/EpwOEjNDSGcJcrXyJL+6nrR1/tHx+hd4JpeehnF6CAA/4bIUp3UyFoeQp3GlG
         1dNJJKsA3XVtPzBsXeJc6vfz8sMXjs1vR6t+wsvoNDLRdFVmQZqDShLchwhmpeZt93Fp
         ZElvqp3NL//6FkB8Dbgtq1Cz6HYchWJp0m7gdjulHW4WBOl5RKHXYF0xVNRCBQYu625L
         HUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680624120; x=1683216120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=curhK01sXfmE2RlMU8WuYjmrkMgBz4YATpsIYnecl9s=;
        b=zH8yFz/qZccD+lWUpShS+xHJNKQqpvMawdeuicjJGCavLU90hLHtZUoDEkyQ5BCIcK
         SpTErZmJmkYvay7BQW1k1RSHhyhP69WUfZOm8MB5HSH+BkSHHEvgewo8u0bi5EiFEann
         2Z0QX2d9UQnafIdcaXZQNVqFL0uDgVwMnEfxNitvn65VXuJg8heS12R6/4O9aSqKoipS
         vDCuasUvLgk53hHJ3cso5FH+qbLEOyoLeAvGMT9nOk3e8n+2iAPVWXyiXz5rZVFDeUr2
         o/3KE+ftPbwjPbsNAtPbAZdT5WZ80x4sH5Pf7plJ8K3r55XNM4Z53+XENO6r9nEC7K5A
         Vsaw==
X-Gm-Message-State: AAQBX9f97YSqC5f2ozm37jY7YsuTAk6mvNOUhkBIUJVz/c7wuw9UcHyR
        wL3w6IQJd+CBRynSPHquiJ74UQ==
X-Google-Smtp-Source: AKy350ZvJfoL6Hx+3SqvCcTcVb7W0gEDSrd0utc/WEB4l8ZL6zAVfLpCbWwyW3n0PqeaSdsSyUVcPQ==
X-Received: by 2002:a05:6e02:1cac:b0:326:3cfc:f702 with SMTP id x12-20020a056e021cac00b003263cfcf702mr133522ill.2.1680624119970;
        Tue, 04 Apr 2023 09:01:59 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z3-20020a029383000000b004062e2fdf23sm3332885jah.74.2023.04.04.09.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:01:59 -0700 (PDT)
Message-ID: <2bbdb38b-a3ac-5127-23c0-56badd113538@kernel.dk>
Date:   Tue, 4 Apr 2023 10:01:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] bio iter improvements
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org> <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org> <ZCsAhDpsiNWpiAxS@moria.home.lan>
 <ZCxAIR8pxOfSE6OR@infradead.org> <ZCxGdj3JKl2RPUJW@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZCxGdj3JKl2RPUJW@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Starting to get personal instead tends to not help to convince your
>> reviewers that it's really useful in general.
> 
> I know you and others like to talk a lot about what you want as
> maintainers and reviewers - but I find that the people who are the
> loudest and the most authoritarian in that respect tend not to be the
> people who drive discussions forward in productive ways.

One issue is certainly that nobody wants to engage with people that
instantly try and make this personal, or just uncomfortable in general.
Then it's better to focus on other things that are more rewarding and
pleasant, nobody needs extra drama in their life. I sure as hell don't.
And unfortunately I find that your postings most often degenerate to
that. Which is a shame, because there's good stuff in a lot of these
patches, but it's often not worth the time/energy investment because of
it.

-- 
Jens Axboe


