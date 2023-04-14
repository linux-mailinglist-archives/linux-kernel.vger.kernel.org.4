Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC79A6E239A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDNMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDNMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:47:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F694C39;
        Fri, 14 Apr 2023 05:47:11 -0700 (PDT)
Received: from localhost ([31.220.114.184]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MF3Y8-1pXwjn0I3s-00FVN7; Fri, 14 Apr 2023 14:46:55 +0200
Date:   Fri, 14 Apr 2023 14:46:54 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] Support Honeywell mprls0025pa pressure sensor
Message-ID: <ZDlLPtAZfxvXMkD8@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:qM0+fcs+gdBSbX/kfsaGH2MsGkuc+4EEZ6ITxfXU83gEhiX35jL
 PgINPQDvb2jNrGLX9tbP/KeVPDErO5MzTbRgPXoTvUPF4KX5LIR3MHKP+0fr/Htso6zQ0Vk
 d+E6O3IE+uA9Pok3aF1o0Zdtn8ckIH8wE0+SSSlJXFfjB9Ff5mvUYE+QLxEg4zBJghwb591
 Mxj6UIsEhh8XtR075gUng==
UI-OutboundReport: notjunk:1;M01:P0:ALk0xDOQTa4=;CKpCNPiyrn/K2EVaXq0naEsEuAW
 j8K4cZkOTAA17Z4KRzOeMgLK2qvTg+lwS05yI0AtOqAbAdkqu7tPFJgkiuOIWY8Z7Y3c7dFvb
 J4J5bG5f8OdRcY4OoGNDiTshhXBnkBGm2Z2RVSNVKiXyvwsmuVf4vDEjcssPN3JIVfDMBFeQz
 P9G6ePSiPdAcITTXR8BRUUcXfESs+9sfnVvs6RKtcdxyW0buO2uC5Z7Bjlf66Eic5WUbs0+T5
 jWV+N0IqG3k9FwYOrGC5ZkkMnTi1ShUCLXNr0bYv+96lv8SbBK8gCCo5+ikZ7D4MdTV8KeOPZ
 LMEkA89m5ItzChEtFYeOE7L40Rb8WCYWk/67ZmexrtmwyzRAh3WqZX0rBP6qJP1hi+1P1qTee
 LczuIcOcxNyh0932X6QNXjqUtVsFm7TdG1mPt9a6+soIhARphWc+/aSdRV01BglG5hIoZjTie
 atruU7Nfk1ypMfCbv4VqjdvsKKPIKl0mxzafGZ+d9ubMpk2eeHX/7qu2mo8lnreqQt6gBueYO
 9gnrmJU+v1lmw9+epAkNlzAWHnm2K9UIprmdH0Hy7m52bc+qs72/vEt1Oz5yBAfkogJdkZd7z
 ZoILsbkhJEC0zaN09oRTf5lQz0x2gbEMtdG6hj5ngbtOkgKZBMU0yCV/lFjrAhj7abMj52rzv
 J/lZINd2JayUmZGRelW5qrkwFNo9IzpnLZT3omi+1Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Honeywell mprls0025pa pressure sensor.

This patch series adds support for Honeywell mprls0025pa pressure sensor. There are a variety of
sensors with different pressure ranges supported.

Changes in v2:
- Patch 1: "dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor"
  - change the global sensor decription of mpr to the specific sensor mprls0025pa
  - change compatible string
  - rename the file to honeywell,mprls0025pa.yaml
  - honeywell,pmin-pascal and honeywell,pmax-pascal: add unit pascal to property names 
  - add new property honeywell,transfer-function
- Patch 2: "iio: pressure: Honeywell mpr pressure sensor"
  - no change so far
  - will be changed and send out as new version when the dt definition is settled down
- Patch 3: "MAINTAINERS: Add Honeywell mpr sensor"
  - no change so far

Andreas Klinger (1):
  dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor

 .../iio/pressure/honeywell,mprls0025pa.yaml   | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml

-- 
2.30.2
