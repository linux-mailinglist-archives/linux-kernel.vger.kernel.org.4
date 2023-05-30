Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF75715D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjE3LYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjE3LYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:24:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A15116
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:24:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-97000a039b2so787488566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685445879; x=1688037879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDFiw2NZ2KPcPpdOWrLyKHVOdaWV9rOrIcNk9rFAJRc=;
        b=i/QmtubuVM5MXH8DA6zZPIe05w2yzKv2VkvS6nhZLXeFg6+6ZtRk3/YDiN6HNB4425
         Tw3kt53UYfd2M1nPEFiZPz3+pJjC4PhSsA/DnFy9xARG6DXhHVsyF0WPwMPZF1p5xnC0
         3IiBJ0THyE1OohLscl0jiff0LCgQbT+nLP0wwfLx7qM+vV1GTIx87zgvAoc93RhW7ZQg
         LArelhyfYpfAvgMKFiYaZejvHJw9+CeKKqj0yyl+L5ZlcQxTQfU5mlhlmRAxopO6t0iU
         f9X8bBkOCBXmpPmHhs/CF+pImoecahnK2jUFqEJim2bpygqWyy6jY+6TB/ChFcCR8FM6
         vm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445879; x=1688037879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDFiw2NZ2KPcPpdOWrLyKHVOdaWV9rOrIcNk9rFAJRc=;
        b=QBgVE8ON2hvMQ6yHa6rXx+gY4Odu8zhpTKqxc8FcmSQtm2UeItTWMEggKOp2atDwN3
         3y/XgJUcG023uAH5PzZS6TtWwEuB09mfZX+DZXeIB1AosPnDqcE2wD5rc1KW6ZIucFsX
         GoRv31wcqRybbMdjX4DQajIvC6UFnBC6Zk3G2UPYPjOsDUKYDzhDwhhNv/hbGjWRL8eF
         c+xn38pFsQh5ykYyLFjjbRHQ8vt1RizttQb75zc5bd1R/ECpDg8DMyD6v9Ez1rbx4sjd
         Z2L85kCV13qcimTzQIz1t6kxwx5OHr+qRcNaIxh2lYNVZ/dCo9ul/L5fDlQdZYnJnyV8
         666Q==
X-Gm-Message-State: AC+VfDz4ItnPmIBB5GIHwR+QYuiR7FSwQTZ50mc126Gupk5PKR9LfEde
        Shd6CYQJGWT22inJd3DCW6nwCaSmthnVQCx8GT+tyQ==
X-Google-Smtp-Source: ACHHUZ6/dT2hu/yep7lq+BIWR9UpAUh4DvHp9z8hf5OQTL0ymetEwXH+zNo8RGxKxATCFM3qtOL55x2t8vcbijVb6xk=
X-Received: by 2002:a17:907:961a:b0:973:91f7:5092 with SMTP id
 gb26-20020a170907961a00b0097391f75092mr2957498ejc.2.1685445879235; Tue, 30
 May 2023 04:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com> <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
 <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
 <2023041100-oblong-enamel-5893@gregkh> <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
 <2023052435-xbox-dislike-0ab2@gregkh> <CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com>
 <2023052647-tacking-wince-85c5@gregkh>
In-Reply-To: <2023052647-tacking-wince-85c5@gregkh>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 30 May 2023 13:24:28 +0200
Message-ID: <CAN+4W8jn2P9LtB=4FtWxFikmEdGGbaxBvUg7swkip+EzqfzHPg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, sdf@google.com,
        error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 6:43=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> So what tree(s) does this need to be backported to?  I'm confused, this
> is a 6.2 email thread which is long end-of-life.

That would be 5.10 from what I can tell. Other LTS kernels have
working tools/testing/selftests/bpf.

I replied here because you asked for examples :)

> It can be avoided by people testing and letting me know when things
> break :)

Fair enough. Earlier you said:

> And selftests should NOT be broken on stable releases, if so, something
> is wrong as no other subsystem has that happen.

Why is bpf special in this regard then?

Best
Lorenz
