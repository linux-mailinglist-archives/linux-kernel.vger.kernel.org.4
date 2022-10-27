Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A460F612
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiJ0LTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiJ0LTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:19:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A81FF20B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:19:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r14so2137553lfm.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HBjdIYKHnjihWoVdQbIvsMMuAIG6cNclbI+ODn1N92w=;
        b=QSskS6PMVyQg/BzbkEFbi/Ezb0Eck6zmd4X3por5XV0w6X/RSFMDHz5t1jawSC5Few
         AdQJlIAN2C1891313ipWefNXiEeGVqOB3ocjjC18ATGx6ZghuWitqiIOadlRdk87EhL6
         5hw7J2hHyj4bQ3FpCGk6A67fFBBjpvnCqLRktNN4+n3E7iucWDJbXUTLtx2i4CiP9lbE
         L5qUADZdF8dxXDmMul1MgB4DIBgDdHdcucu+r72C1fezUZ2cUNllMCbHJk6naIAirP4f
         9OgsEDhNAf7qYhVNKCNOZ2oUnRaIUvobs5PVXihbJWrEHY8u0M/YofobRyrtjLJVsAYJ
         o7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:reply-to:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBjdIYKHnjihWoVdQbIvsMMuAIG6cNclbI+ODn1N92w=;
        b=BbolW1+8MNz/rzNrAj+i6zonmM9eA1p8f9+IfI3o0nFyvA1qRaoSkw0QSfw0DuLXqF
         eu9XBztxoq+rrcLl2ZNVn8xUKjxudQx7fdzjrqBOlyxpGFTbeseaZ6tJQ46nZ5DL2gnB
         HeIu2UYfPYu6M58keVe+7aWMaSVdlkaxhmhZ/+bTJlzmKKY6lMjDtUINVHZEAsMGNlNz
         qo1968/Sgcnzn5msJ9+Z1PjuagFfRkqdZSiidgSCbd2Mg4EFu72qXQh69h99wluQ+xQD
         HNMC+3mStk7AFYD+TZWfJEwUyd+a7fV+UeQcBlGO13oH8y4pvlX2AjiF/z6I24md5FUe
         ZEtA==
X-Gm-Message-State: ACrzQf142RK91kMA1YZ9CdUhyQqDDDsS3Ob39dEGuIGvslwOCd4ZoQOz
        fkUqoqAX0ydnVogkm090DSYYQLU2S+9JHpnXqA4=
X-Google-Smtp-Source: AMsMyM4GyYe+JZaslcqmRvzjjKiaU39jqTDGgXE7JLkzBvS04SAEz9R3yLI2ca8tgzi4ayVXzJ0C5pHNFgOkdt7dprU=
X-Received: by 2002:a05:6512:1096:b0:4a2:f71:60ea with SMTP id
 j22-20020a056512109600b004a20f7160eamr20731058lfg.232.1666869551920; Thu, 27
 Oct 2022 04:19:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9986:0:0:0:0:0 with HTTP; Thu, 27 Oct 2022 04:19:11
 -0700 (PDT)
Reply-To: davidtayo2007@gmail.com
In-Reply-To: <CAPE=1VoKTNi95H2w+Y-7oSM4QcWxAbD1z6T45obAnKw99QCNSw@mail.gmail.com>
References: <CAPE=1VpRt1h9niqeRQ-uLWKadJBgTd9RHn4iQO97h-Z=W00pxg@mail.gmail.com>
 <CAPE=1Vrv+VykHfn-fJG5-LC+NS7jwNa3F7L1PT-JEN6EozWmcg@mail.gmail.com>
 <CAPE=1VrG-CPfg++xWvqzLimzKicw1EyChj6basWwfyE9KPJYkg@mail.gmail.com>
 <CAPE=1VpxYeHS6-3uPTY83K2-_ns+H+vRg+Tcfzm5esLbU_JqAw@mail.gmail.com>
 <CAPE=1VpNrY64__+Mdw+tr_2NNwj2W6N1Ek0Q9sPw+LZiVjd_LA@mail.gmail.com>
 <CAPE=1Vq4G4FmT4ysqwf4tXo7Q9-fuiv+EAYF=cm-3HPpQuhPqg@mail.gmail.com>
 <CAPE=1Vppi-wdFqon3QbTEGLWRsmSfrmtVcmagzCfpRcimd8TUA@mail.gmail.com>
 <CAPE=1VqTPCNF5AbYtZgzzHb0CrAv0OXPtgyEJU2PRgM6bfWfcw@mail.gmail.com>
 <CAPE=1VoYO25T7Cmab1+ZqxLu7YGTrqGv1VnxeH0qWLsy+Q_REA@mail.gmail.com>
 <CAPE=1Vq3H+czure1HwPJ-_EgsKuwSph2qTw16yHyYjYzZm5q1g@mail.gmail.com>
 <CAPE=1Vr7YBDJbwhDokJAREv6RQqzae+xf_J8jZiQr2C9Hp=b=Q@mail.gmail.com>
 <CAPE=1VrL60iNY1WD6-tp2-WgzAdHVYCbW8LoStPuMYsdB0_aaQ@mail.gmail.com>
 <CAPE=1VpSEL2Qd=3c7sXsZ5yqjAGa+UCpinAEcNd81PDKZSmmdQ@mail.gmail.com>
 <CAPE=1Vptt4V4Qb6AbszpxPE58HhFRgL-_-5-u6XfEOcmWm2zug@mail.gmail.com>
 <CAPE=1Vp739Uk=FdoG1-47RyRostAFtXPhuXJeef7OMzK9BT4AA@mail.gmail.com>
 <CAPE=1Vp4xdi_MybaadfczqaVVQDYrpw8Ac=QG=Sn3z3vEqp+1A@mail.gmail.com>
 <CAPE=1VpVbZRy4eSi2LD4Vcc0VZ02+4=YXfqf_OGvwf4Q2FQkaQ@mail.gmail.com>
 <CAPE=1VraeMUYtYbxckJ4XgupA9Q=3d8xps+NmzPU49bzfs9ZiQ@mail.gmail.com>
 <CAPE=1VpX6f7S3RsFp7Crgmo9mbqukbJq1Y_xcE-9scxkabqHbg@mail.gmail.com>
 <CAPE=1VrDBNOGtE_Q0oQrorJJTfGGQ_+0_qTTYEEJoFv0Au_i-g@mail.gmail.com>
 <CAPE=1VqC1ZUTBKqyaPQ0+a15H4Njz73ADMzr1awdkxjCj-LO9g@mail.gmail.com>
 <CAPE=1VqT=kaHjYDuw1-+0+Bg8G-eowU18Sk=-A_tWkWf_Bh-ug@mail.gmail.com>
 <CAPE=1VoNnEA87E-7fsVLOZD9zC78k3J36tQp1ih376qo2b-Hyw@mail.gmail.com>
 <CAPE=1VqCOGypaze3FzRArE5JJwGrODeb1EKnkZoJrV39h2KzAg@mail.gmail.com>
 <CAPE=1Vq=dzF_fj3frrOx1SDLbgXaz+_51k7fBcZYiQYHd+5R-w@mail.gmail.com>
 <CAPE=1VqDH0LhYBHgUvoxq-1RGmLXU9iGmaHc=Qxf=PiN_498cg@mail.gmail.com>
 <CAPE=1VoeC+tUpz6a0JaMmnvOVGQNVascPBk+6+qQoa3qwdHDzg@mail.gmail.com> <CAPE=1VoKTNi95H2w+Y-7oSM4QcWxAbD1z6T45obAnKw99QCNSw@mail.gmail.com>
From:   david tayo <martinlarcher1001@gmail.com>
Date:   Thu, 27 Oct 2022 12:19:11 +0100
Message-ID: <CAPE=1VqLW58ywO48tw2eGVC=81qbQq0Sq_x2faRvqzKv5ffoOw@mail.gmail.com>
Subject: =?UTF-8?B?R3LDvMOfZSw=?=
To:     davidtayo2007@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gr=C3=BC=C3=9Fe, ich hoffe, diese E-Mail erreicht Sie gut. Sie haben nicht =
auf
die Informationen geantwortet, die ich Ihnen zuvor geschickt habe.
Bitte melden Sie sich bei mir, es ist dringend, wir m=C3=BCssen uns
unterhalten

Mit besten Empfehlungen
David Tayo
