Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA16BEA2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCQNgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCQNgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:36:05 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C243430C;
        Fri, 17 Mar 2023 06:36:03 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id mg14so3403795qvb.12;
        Fri, 17 Mar 2023 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679060163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNVBg27oIWutxFT+tTBlw9bXDaXQxeVQk+w6ErQV8u0=;
        b=OFGFge9nJtxmQpEupx9yRDWqHS3snsTOJg+Lp3RztPeBlI0Sa4RxKzjyWjYisGzhIr
         P/qEy2ZOe+DYk220tj+xjOTGe8FPuVW+9BJByl4Mh4FTZooYcLW22vKWfwmNkCSWIJcj
         Yb+4sEQvu3hNxeOYXJGfES8Ztg/8TiO64BdDSfrYqrGz+zQRuzS6Anv8R0sfiD5ywrdE
         bPBctJA/84oBJwyOk4Q67ZEAunF/2jbNKWyPms8Ryl7HDGHfal/tOgWloGWEEwEA3ARh
         lJ0ICMwpVZXUOSo/Y2RIDeMwP1ZHAXJvqUhG+MtsVabHB3HejfjI7bqvqON4DBSwLqcd
         KWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679060163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNVBg27oIWutxFT+tTBlw9bXDaXQxeVQk+w6ErQV8u0=;
        b=r90zK7CZSVEf6XyNZ5Nx5MQix25FeQr4hUMkDxh1IKBjSECXeBWaDIl3P2a0kgNcGD
         lASbxxnTQHdrvlTqTgULrA32hUt3M8FvjBr/a6i2dVB9LD0UtMQk5oa21tSAjhw2G5Nz
         z1bEwxyndBn5+xCDcOdEjm7OHbdQDXjeh9EAzpuRv2tr3r0/SXCv+S/SerRlFDuEKQHc
         vJvBhZrU+gKClBUMy5h6Cx0l3K8epeSQMV5pCSk1bYQIEGnfjdPJv3GXp1NRGMkMMnvy
         3p4UpUUuZpn2u3zfsPpLQLW0drP4KrDiN9QIefUXIhkEuu2MaBC5lN47Sx/352fRTFnv
         fSSg==
X-Gm-Message-State: AO0yUKX49AXLTuMhXVe+pdd4mKWqp5S7kB2bICjDALV3qVOJZO2zjUFT
        fVf2BYid48QOMap/xt7HNKkvPGWYxDp//hHHk4o=
X-Google-Smtp-Source: AK7set803kNbp/TPA94Q6gV9IK15KDMVcbMby2EcvOAIUfF27bVl2Tade8EBMlo3YhaPYAiSp3UgfI0azs4oQAMtqP8=
X-Received: by 2002:a05:6214:9a8:b0:56e:ff38:46a2 with SMTP id
 du8-20020a05621409a800b0056eff3846a2mr5451455qvb.10.1679060163025; Fri, 17
 Mar 2023 06:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230316225736.2856521-1-david.e.box@linux.intel.com> <20230316225736.2856521-2-david.e.box@linux.intel.com>
In-Reply-To: <20230316225736.2856521-2-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Mar 2023 15:35:27 +0200
Message-ID: <CAHp75VcP5jf4Tt-U7cs77gnTcUpQbQ+exXjOOc5epPRDfT0h0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86/intel/pmt/telemetry: Add driver version
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 12:57=E2=80=AFAM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Add a driver version number to make it easier to track changes in
> backported kernels.

Sorry, but NAK. As Greg KH said, we do not use this anymore (in Git
era) =C2=AD=E2=80=94 the SHA from the Git _is_ the version of the driver.

--=20
With Best Regards,
Andy Shevchenko
