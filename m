Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4276072F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJUIyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiJUIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:54:01 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF83D2505C2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:53:58 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221021085355epoutp0481a8c1832ee0e1e0b5e5e6777636c078~gCZ3lKTOj2171121711epoutp04e
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:53:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221021085355epoutp0481a8c1832ee0e1e0b5e5e6777636c078~gCZ3lKTOj2171121711epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666342435;
        bh=x/phL+eYSXCfTdP7uP/ETDDranDm7apG6KyU9u6rj8c=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=FjzHwUPA5TBwL+190EZJU2jsXNu+5oEnvNaw8N/BdDqGTRFTK0u65H/pTPydAJxrQ
         RdkFI32sPWxv+8JbIKmmUroVFL5yp74bUDqXPhSaXMGMMPzKXel4t77SVALHlJ5dnc
         JoKKeabgYGL7M+YVJ+DYpyfhHjrH9lY+47WE4rgs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221021085355epcas5p492dd30305a59e074ce31dbe43c38bed6~gCZ2-rNI_0217502175epcas5p4t;
        Fri, 21 Oct 2022 08:53:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Mtytm59Ypz4x9Q5; Fri, 21 Oct
        2022 08:53:52 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.6F.10166.F1E52536; Fri, 21 Oct 2022 17:53:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221021084433epcas5p4ebf6fff47284dbbbf27f134c3c7f58d3~gCRrlPW7f2748327483epcas5p4T;
        Fri, 21 Oct 2022 08:44:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221021084433epsmtrp2ba05f3dabac65ccb5de4e700eb4a32f9~gCRrkL4De1220012200epsmtrp2M;
        Fri, 21 Oct 2022 08:44:33 +0000 (GMT)
X-AuditID: b6c32a49-d73ff700000227b6-90-63525e1fdf65
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.5A.14392.1FB52536; Fri, 21 Oct 2022 17:44:33 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221021084430epsmtip1ccdd688f23bbb31b9bd2deddaa8412b7~gCRo6lYw13019030190epsmtip1P;
        Fri, 21 Oct 2022 08:44:30 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221014151325.GA1940481-robh@kernel.org>
Subject: RE: [PATCH 3/6] dt-bindings: sound: Add sound card bindings for
 Tesla FSD
Date:   Fri, 21 Oct 2022 14:14:29 +0530
Message-ID: <04b901d8e529$573b17e0$05b147a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwIZxyFGAJxV9qUBrWX0b6yc6o/A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmhq58XFCywbv/BhYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCwWbf3CbtG5q5/VYtaFHawW
        //fsYLc4/Kad1WLD97WMDvweGz43sXnsnHWX3WPTqk42jzvX9rB57Hu7jM2jb8sqRo/1W66y
        eHzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0vZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDA
        wMgUqDAhO+Njx3O2gktuFUvOzGRsYJxu3MXIwSEhYCLRcpSvi5GTQ0hgN6PE0TsGXYxcQPYn
        Romzy78zQTjfGCW+3T3KClIF0nD55U1miMReRonvi26zQTgvGCUerzrICFLFJmAusWjvUjBb
        REBVomnWAxaQImaBLmaJyY+ngI3iBCpas/ExE4gtLBAicWbLYTaQm1iAGqbsFwMJ8wpYSrza
        0MgMYQtKnJz5hAXEZhaQl9j+dg4zxEUKEj+fLmOF2OUmsX15NytEjbjE0Z89YJdKCLzgkJjz
        bw4LRIOLRMfDjUwQtrDEq+Nb2CFsKYnP7/ayQdj5EtM+NkPZFRJtHzdA1dtLHLgCMocDaIGm
        xPpd+hBhWYmpp9YxQezlk+j9/QSqnFdixzwYW1Vi/fJNjBC2tMS+63sZJzAqzULy2iwkr81C
        8sIshG0LGFlWMUqmFhTnpqcWmxYY5qWWw+M7OT93EyM4bWt57mC8++CD3iFGJg7GQ4wSHMxK
        IrwF7wKShXhTEiurUovy44tKc1KLDzGaAoN7IrOUaHI+MHPklcQbmlgamJiZmZlYGpsZKonz
        Lp6hlSwkkJ5YkpqdmlqQWgTTx8TBKdXAxG7ge/ux1bQHpYe+zO1h+9canSTU4Livp2P1uXPW
        yU9TO5M2X8z3WGjjc+r4kvZ/2r3paX9fBtzYdC07M/n7hvPrF7VdlD2nvbTl2+/sH97bPzq6
        fhQvnXbdWPf86xvbnt7+rX32WJ+39fI1M4/93/akIeRpwsX0Saf1Pu3uuMP1a4lF1uHt0TvM
        zr/8Kql0IcOgtXp3VL1c2HNlix1+fodb3UzL3gReTXyffuGG5VT96A6lD2sXlaXcdW6IyE9j
        4rQ4qerme2Ixx/8fLYc8p16wD5uwtUVM/On5Tt7F19/5cjRdnFj24VJXsuxn8VTnYiextxmb
        jaU5leqtbwVaRMdZB8jYXmxVv5+29pqIphJLcUaioRZzUXEiAOUfVqJkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnO7H6KBkgyWfOSwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVks2vqF3aJzVz+rxawLO1gt
        /u/ZwW5x+E07q8WG72sZHfg9NnxuYvPYOesuu8emVZ1sHneu7WHz2Pd2GZtH35ZVjB7rt1xl
        8fi8SS6AI4rLJiU1J7MstUjfLoEr42PHc7aCS24VS87MZGxgnG7cxcjJISFgInH55U3mLkYu
        DiGB3YwSpz6eZoZISEtM79/DBmELS6z895wdougZo8SF21/BEmwC5hKL9i5lBLFFBFQlmmY9
        YAEpYhaYwSyxumMPI0THG0aJvZ9vsYBUcQJ1rNn4mAnEFhYIklgyZSpQnIODBah7yn4xkDCv
        gKXEqw2NzBC2oMTJmU/ASpgF9CTaNoLtYhaQl9j+dg7UoQoSP58uY4W4wU1i+/JuVogacYmj
        P3uYJzAKz0IyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw
        7Gpp7mDcvuqD3iFGJg7GQ4wSHMxKIrwF7wKShXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZ
        LySQnliSmp2aWpBaBJNl4uCUamDaa3RRO/7kbbHg5Y90XzwW8hTbaNESsFW7lVem8luxrM5R
        k/k6BfV7351Jj+/O7X8ZHb9awf3n/hQW1m/3Nx909RDdt/v0m3MFjd4xEfVMHyzOJ4ULh6nP
        ndSo+VQ8Z6pl3oLtf79an2V34tj9hpdf9JrLTQZN+chwhfbZi4u7J8X6nBVItXvwcVJ6af/E
        xw8tQis6ztfk9NmfZN0wa1aGenrQlTeK+yZ9fsvxbG9yULB8898pO4+sDtjisvL+ftklhzl2
        z32R4Pb43i7PJ4lHYo/VCioLvO6VZGxUOSZQFxXyK191UsKGvvOO6l37U+Zf2C0X8Wu+yJIZ
        iS47Y/e/59bKajB0uJQzV4u564ASS3FGoqEWc1FxIgAbyyiATAMAAA==
X-CMS-MailID: 20221021084433epcas5p4ebf6fff47284dbbbf27f134c3c7f58d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104901epcas5p1a61ea81c3b1640bd8a064633c0b1e40d
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104901epcas5p1a61ea81c3b1640bd8a064633c0b1e40d@epcas5p1.samsung.com>
        <20221014102151.108539-4-p.rajanbabu@samsung.com>
        <20221014151325.GA1940481-robh@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 14 October 2022 08:43 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> Cc: lgirdwood@gmail.com; broonie@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com; alsa-devel@alsa-project.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org
> Subject: Re: [PATCH 3/6] dt-bindings: sound: Add sound card bindings for
> Tesla FSD
> 
> On Fri, Oct 14, 2022 at 03:51:48PM +0530, Padmanabhan Rajanbabu wrote:
> > Add dt-binding reference document to configure the DAI link for Tesla
> > FSD sound card driver.
> 
> The simple-card or graph-card bindings don't work for you?
Thank you for reviewing the patch.

The actual reason for having a custom sound card driver lies in the fact
that the Samsung i2s cpu dai requires configuration of some Samsung
specific properties like rfs, bfs, codec clock direction and root clock
source. We do not have flexibility of configuring the same in simple card
driver (sound/soc/generic/simple-card.c) or audio graph card driver 
(sound/soc/generic/audio-graph-card.c). The binding has been added to
support the custom sound card driver.

I understand from your query that the newly added card has device tree
nodes and properties which are used in simple card as well, but having a
different or new prefixes. I believe to address that, we can restructure
the string names to generic ones. But I would like to understand, to reuse
the simple card or audio graph card bindings, can we add secondary
compatible strings in the simple card dt-binding for the custom sound card
to probe ?
> 
> >
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > ---
> >  .../bindings/sound/tesla,fsd-card.yaml        | 158 ++++++++++++++++++
> >  1 file changed, 158 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> > b/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> > new file mode 100644
> > index 000000000000..4bd590f4ee27
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> > @@ -0,0 +1,158 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyright
> > +2022 Samsung Electronics Co. Ltd.
> > +%YAML 1.2
> > +---
> > +$id:
> > +https://protect2.fireeye.com/v1/url?k=4ae54403-157e7d1c-4ae4cf4c-
> 000b
> > +abdfecba-9eb398ea304f8ae8&q=1&e=4935bed0-ce62-47dd-8faf-
> 4750b01e22d3&
> >
> +u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fsound%2Ftesla%2Cfsd-
> card.ya
> > +ml%23
> > +$schema:
> > +https://protect2.fireeye.com/v1/url?k=8c72226e-d3e91b71-8c73a921-
> 000b
> > +abdfecba-3ce999f6c052255b&q=1&e=4935bed0-ce62-47dd-8faf-
> 4750b01e22d3&
> > +u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: Tesla FSD ASoC sound card driver
> > +
> > +maintainers:
> > +  - Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > +
> > +description: |
> > +  This binding describes the node properties and essential DT entries
> > +of FSD
> > +  SoC sound card node
> > +
> > +select: false
> 
> Never apply this schema. Why?
Sorry about it, let me change the select property to true in the next
patchset
> 
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - tesla,fsd-sndcard
> > +
> > +  model:
> > +    description: Describes the Name of the sound card
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +
> > +  widgets:
> > +    description: A list of DAPM widgets in the sound card. Each entry
is a pair
> > +      of strings, the first being the widget name and the second being
the
> > +      widget alias
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +
> > +  audio-routing:
> > +    description: A list of the connections between audio components.
Each entry
> > +      is a pair of strings, the first being the connection's sink, the
second
> > +      being the connection's source
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +
> > +  dai-tdm-slot-num:
> > +    description: Enables TDM mode and specifies the number of TDM slots
to be
> > +      enabled
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8]
> 
> maximum: 8
Okay
> 
> > +    default: 2
> > +
> > +  dai-tdm-slot-width:
> > +    description: Specifies the slot width of each TDm slot enabled
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [8, 16, 24]
> > +    default: 16
> 
> All the above have types defined. You should not be redefining the types.
Okay
> 
> > +
> > +  dai-link:
> > +    description: Holds the DAI link data between CPU, Codec and
Platform
> > +    type: object
> 
>        additionalProperties: false
okay
> 
> > +    properties:
> > +      link-name:
> > +        description: Specifies the name of the DAI link
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +
> > +      dai-format:
> > +        description: Specifies the serial data format of CPU DAI
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +
> > +      tesla,bitclock-master:
> > +        description: Specifies the phandle of bitclock master DAI
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +      tesla,frame-master:
> > +        description: Specifies the phandle of frameclock master DAI
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> 
> These are common properties. Drop 'tesla'.
Okay
> 
> > +
> > +      cpu:
> > +        description: Holds the CPU DAI node and instance
> > +        type: object
> 
>            additionalProperties: false
Okay
> 
> > +        properties:
> > +          sound-dai:
> > +            description: Specifies the phandle of CPU DAI node
> > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> > +
> > +        required:
> > +          - sound-dai
> > +
> > +      codec:
> > +        description: Holds the Codec DAI node and instance
> > +        type: object
> 
>            additionalProperties: false
Okay
> 
> > +        properties:
> > +          sound-dai:
> > +            description: Specifies the phandle of Codec DAI node
> > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Already has a type. Need to define how many entries (maxItems: 1 ?).
Okay. I'll update in the upcoming patch set
> 
> > +
> > +        required:
> > +          - sound-dai
> > +
> > +    required:
> > +      - link-name
> > +      - dai-format
> > +      - tesla,bitclock-master
> > +      - tesla,frame-master
> > +      - cpu
> > +
> > +dependencies:
> > +  dai-tdm-slot-width: [ 'dai-tdm-slot-num' ]
> 
> This should be captured with tdm-slot.txt converted to schema.
Okay
> 
> > +
> > +required:
> > +  - compatible
> > +  - model
> > +  - dai-link
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    sound {
> > +        compatible = "tesla,fsd-sndcard";
> > +        status = "disabled";
> 
> Why have a disabled example? Other than your example won't pass your
> schema.
Thanks for noticing, I'll double check and change the example keeping the
status 
as enabled
> 
> > +        model = "fsd-i2s";
> > +
> > +        primary-dai-link-0 {
> > +            link-name = "fsd-primary-0";
> > +            dai-format = "i2s";
> > +            tesla,bitclock-master = <&tdm_0>;
> > +            tesla,frame-master = <&tdm_0>;
> > +            cpu {
> > +                sound-dai = <&tdm_0 0>;
> > +            };
> > +        };
> > +
> > +        secondary-dai-link-0 {
> > +            link-name = "fsd-secondary-0";
> > +            dai-format = "i2s";
> > +            tesla,bitclock-master = <&tdm_0>;
> > +            tesla,frame-master = <&tdm_0>;
> > +            cpu {
> > +                sound-dai = <&tdm_0 1>;
> > +            };
> > +        };
> > +
> > +        primary-dai-link-1 {
> > +            link-name = "fsd-primary-1";
> > +            dai-format = "i2s";
> > +            tesla,bitclock-master = <&tdm_1>;
> > +            tesla,frame-master = <&tdm_1>;
> > +            cpu {
> > +                sound-dai = <&tdm_1 0>;
> > +            };
> > +        };
> > +
> > +        secondary-dai-link-1 {
> > +            link-name = "fsd-secondary-1";
> > +            dai-format = "i2s";
> > +            tesla,bitclock-master = <&tdm_1>;
> > +            tesla,frame-master = <&tdm_1>;
> > +            cpu {
> > +                sound-dai = <&tdm_1 1>;
> > +            };
> > +        };
> > +    };
> > --
> > 2.17.1
> >
> >

