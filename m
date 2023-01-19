Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4960674C59
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjATF3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjATF2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3043E0BB;
        Thu, 19 Jan 2023 21:23:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 332D3B82726;
        Thu, 19 Jan 2023 19:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68BFC433F1;
        Thu, 19 Jan 2023 19:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674158234;
        bh=YvR/w5eKFpu1A0Yi53SCAxbUZ3sMKB9y4mXIIgVvUFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b5qt7o1/sqMdU6AFjjIcmJXQEJKqZiCnXKLb5MStq9uyzOXgG0PBGguO1tLr4chah
         PPJlg4EED3ACTgWZRCwCy1fZLAVQacAi3OjKGOkhATqjRCO7fFvple5cPqo/czonSE
         sffmqPpIZS5V9wm/JksN8dANVILYk1xscLLDPm5vuSS4AEA9bdTuEsKSfh0ZiLIpiB
         QvOumaBMGIOKCzGLs8fea6LlOsuQN4d/kE8ULvbjgOYcrxPZADIl1g5j8kwPrc88lZ
         qPlbTf8ZjC10UdRJx/tmhvUhBhbjrdPwDDkO5YJ/AczRQgHdG1tLRGRPg8mUgyTfId
         U7zeBtq7HTtVQ==
Received: by mail-vs1-f46.google.com with SMTP id k4so3391285vsc.4;
        Thu, 19 Jan 2023 11:57:14 -0800 (PST)
X-Gm-Message-State: AFqh2ko6zy/C5PmJ1uwl1Eo8xAQbPRDchwqHJ0G2ka2O9nTZje2V9g5s
        JgxCrygfGI2/wZ4Fy9DQOaJztvQB7YDAe6f81Q==
X-Google-Smtp-Source: AMrXdXto5Lwb1f3PGyYWK0XSc7w8sqifaP3Jj00Cp/pE9GJlhsSUHjH1yNJpXLa6NVF84aDN7ySy+z7EHEE7IgERQNM=
X-Received: by 2002:a05:6102:5490:b0:3b5:1fe4:f1c2 with SMTP id
 bk16-20020a056102549000b003b51fe4f1c2mr1672722vsb.0.1674158233768; Thu, 19
 Jan 2023 11:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221219154948.GA1439405-robh@kernel.org> <96590704-fc2e-5a30-15b9-32fda9cb571e@socionext.com>
 <0c5d917b-5cc9-2b09-390c-8888a1de2a48@socionext.com>
In-Reply-To: <0c5d917b-5cc9-2b09-390c-8888a1de2a48@socionext.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Jan 2023 13:57:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKPEeQW3WER+K0UgWp8yx_Fh4OB9o1skU9mndM-=SYV7g@mail.gmail.com>
Message-ID: <CAL_JsqKPEeQW3WER+K0UgWp8yx_Fh4OB9o1skU9mndM-=SYV7g@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] dt-bindings: soc: Introduce UniPhier
 miscellaneous register blocks and fix examples
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 2:22 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Rob,
>
> On 2022/12/20 10:13, Kunihiko Hayashi wrote:
>
> >> You sent this To me, so I'm assuming you want me to apply it?
> >> Otherwise, it can go via the Socionext tree. Let me know and I can fix
> >> up Krzysztof's comments and apply the series.
> >
> > Currently I don't have the Socionext tree for pull-request,
> > so I'd be happy if you could fix up the comments and apply the series.
> Could you please do the above?

Yes, I've already applied this.

Rob
