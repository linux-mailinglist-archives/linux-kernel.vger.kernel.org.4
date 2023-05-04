Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB06F79CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjEDXo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 19:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjEDXo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 19:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A769B76A2;
        Thu,  4 May 2023 16:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CD1A63996;
        Thu,  4 May 2023 23:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77593C433EF;
        Thu,  4 May 2023 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683243865;
        bh=sqd3QxYIfp81aQWLqFP3GRC/sgGTwPJBsZB6PBO7r2Y=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=GD2uU/jjt2I4vxxcAYmCkSt9/FKI7Jo9pEiCdvmCuRLh2n2m9V9IlVd85TsMmmrjc
         8Rsz6eBRutQE0tSg6DVUZDyfaYKsMC4IPAduSQKLhmUq8TjKV+FblEKicwIpI9X6iH
         IvCG5Nx+6ZvLCmQVY5QADGjtIkzMCx1fkHWMoGcDxs42e4twc4+iFe0JNKysHEp52f
         z9oPDg/X6kmOJY5yvwSJFMS3AuYPb7Db7HGpePcnLlwWlUJroLtEIqiBLUXNZy7F4S
         T7Ba/jTOM/plLO4CsuGcA0MqLn/akmND1F40hQf6g56VDttox+BRlNTSiMvDd8PiW+
         9HK0QpzS5edvA==
Date:   Thu, 04 May 2023 16:44:24 -0700
From:   Kees Cook <kees@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>
CC:     Miguel Ojeda <ojeda@kernel.org>, Bill Wendling <morbo@google.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: Add __counted_by macro
User-Agent: K-9 Mail for Android
In-Reply-To: <CANiq72nZNU-x_8ONmtzainxDUMedFT+FHww1xu9Ho07gxfAD9w@mail.gmail.com>
References: <20230504181636.never.222-kees@kernel.org> <CANiq72nZNU-x_8ONmtzainxDUMedFT+FHww1xu9Ho07gxfAD9w@mail.gmail.com>
Message-ID: <40D4BB7A-2583-45B9-B76A-E174CAC4B248@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 4, 2023 11:27:32 AM PDT, Miguel Ojeda <miguel=2Eojeda=2Esandonis@gma=
il=2Ecom> wrote:
>On Thu, May 4, 2023 at 8:16=E2=80=AFPM Kees Cook <keescook@chromium=2Eorg=
> wrote:
>>
>> + * Optional: future support coming in clang 17 and gcc 14
>
>Should we just say:
>
>    Optional: only supported since clang >=3D 17
>    Optional: only supported since gcc >=3D 14
>
>even if they are in the future? That way we avoid changing it later=2E
>If somebody asks, you already say it it is in the future the commit
>message, so it should be clear enough=2E=2E=2E :)
>
>And if the compilers end up not supporting it on those versions for
>some unexpected reason, well, we will need to fix the comment either
>way=2E

Yeah, fair point!

>
>(I can change it on my side if you prefer)

Sure, thanks! (But I'm happy to send a v2 if that's easier for you, too=2E=
)

-Kees



--=20
Kees Cook
