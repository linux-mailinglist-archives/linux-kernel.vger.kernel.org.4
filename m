Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6174414B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjF3RdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjF3RdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:33:08 -0400
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D79E6C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:33:06 -0700 (PDT)
Received: from 104.47.7.176_.trendmicro.com (unknown [172.21.19.131])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 13DE110A258B6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 17:12:33 +0000 (UTC)
Received: from 104.47.7.176_.trendmicro.com (unknown [172.21.178.36])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 4D1DA10000B8F;
        Fri, 30 Jun 2023 17:12:31 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1688145148.926000
X-TM-MAIL-UUID: ecc4e6de-1b24-41d7-9602-6e0885476716
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.176])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id E254E10000E20;
        Fri, 30 Jun 2023 17:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcicaTdYXgJ2Q9pcX8iu5zv+a2OKAQaqWkHAypkYVUv7sq9/T6IgB9S94TIzF6Abhf5XN3X+/mO+o/75Dl/8GSymlsFtg7Ov3nwL7v3A7STFe/xwkWeDAkXRxZkkjUEaxRowxvOf88Ieq94rncbnEXjpcsNhB5QGefszybw1mokTxRUhhA/wwmS0XbG05VuuYB7WGWhqSmMZjSwuJzFiKVWI4x/2GzPlhJI9N9pZSAWxruIUxGaf5EAZroxncpRMzoBK1QMjXPt1EXoVglY8vGZejsLIrbntyJSe24jhIdTNvrKjEaqXbjPTxJ9zrr8VILCmpcPGOQb1bgaTj9EHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdO2lE+LOBQ7ZjewmLPpUugGZYDZX1sH1iViVOdfHXY=;
 b=UfeidBGrk25sl6arl7pnTs8d8571EpXJXGiV1pv/EjcF0K6Un7/3UCJ+ycbC/JbKfGCVy9aTLCFdSjlVXfToNEGAXKXjHeippkmGB/qAIHSQiYyJWdCVGMpOLC+V/wXZDKW8Zlpc2epLpjAkFmhz5kRW6tKNI91YvNn1AUgvhfdKzQuS2xeqIuHW5qbJMPt8s6UnNnRWN/plw5qgWv6W1PgBo96BFhWQmZWRydH+hm4p4F6IDh+kSOzKC5zfFobLgEfaHvWVKaNeK6jUNFTrXVDR8EjDd3rCtsXAHnwmbDTjQutwi8PopnQ95B+4YNzcUMB7F8rfDJHxX1/06Vy90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=arm.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        John Stultz <jstultz@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC PATCH 0/7] Add virtio_rtc module and related changes
Date:   Fri, 30 Jun 2023 19:10:43 +0200
Message-Id: <20230630171052.985577-1-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT048:EE_|BEZP281MB2773:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4c79124b-aad8-415c-7527-08db798d2de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgYi7Fjn10lvcHHaVkT3xtyqb3hUjIRRpj27QrOPX+QDSBQ9dS15ey2gtQfI3pUDtavqN9EB0lNz6PqRG2IsHBywhzeoBm823QDBCKjOSuMoaybPq4Q6yRDi3rA2++eR64BAkEQa/DyluqOqTe2KJ4kpSlqoaNR49O8bruLXCeIH0a3j7g5II5bNE86SjaP+4KyatDWoj8FpqspcOgd6m3jVIHRs/fivdZC0V5yihxIXfkg4WyBDGKZix1DBVlqDzb0Df0H+sSC0nLRl0uW0J5tZmGyrZM4euhAhx4DHXxRs0ryzUr6Fk1GpTO2z4wRqNe9STXCjXKaTj4wWkd39f9qvyCrxqcz6ERWRwIOjkI/5IlO1WN+dLxvwS9Ou8cGDIRumUdPrKoKRMz6GjjU3R3BZnNcquPZ/9zoQ9N1z6b2qG6mfuU7xsCUVbSN19PYrYDddFVQSsSOzZLZzLDn84OZz7Lhg9xg6lIqPE6V2SJj1i6GRFMJD0CozmoK1SJGURX9nsxrOqub9QmaLt9kpi65eRZh7I1Y+U+1gUgrORjRMRovXB3FzMBfaDdp5Uedi7apR1kd0jFxnpi63Gc24IJPo7dRFqdnSDNAtRbzmxYj23tyVW4h7HSyPJK05x+0lRUd2fHWYoNwyiY16gsg/fj+O6qnEdaX3E+5VBVmmDeWNdIgYihmTVUgBezYBZaJ35WBafLeAX8uUZ8Z04Pf03cXEXbj6SlymPJtawsEvFWpGyOsuA23PIOFxjsg1FILkVSnieC8DjWsJzEGQPhcQIyvbgh6eT5CCNYqz3/PWlIKPZdsBYGJurgK2iEduiJRH
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(396003)(39840400004)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(41300700001)(82310400005)(186003)(2616005)(83380400001)(81166007)(336012)(1076003)(47076005)(26005)(36860700001)(966005)(40480700001)(54906003)(86362001)(478600001)(316002)(2906002)(42186006)(36756003)(70586007)(70206006)(4326008)(5660300002)(7416002)(44832011)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:12:26.9310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c79124b-aad8-415c-7527-08db798d2de0
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT048.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2773
X-TM-AS-ERS: 104.47.7.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27724.001
X-TMASE-Result: 10--21.904400-4.000000
X-TMASE-MatchedRID: QkBk6NM3bYntZDpZlNWg4O3qPLdU3cUZmmVIK8ewxWFzGLNi78J47a1E
        3eK47PQv8NnPKwQ6MAXIfQ4ROYO30qR3czjQoJVEzHEBgfJ+fh7XT+yjPvIHsSPyEm8irOu0hto
        XpFBNnP0hNGbe+yEJt2s6L9BEkSPmik3s3JIv+NL24vmE69obUuZaGzHq+v3RvISQdexW7wlJus
        yl/yyXJshX3ePBhmH9FAYnhafAyPf3/e1f1P1EBXzRkrQz4xEZXEX7ABoMsg2XYoGYte3R6uKgz
        T/C1UJV14kqJij0HUVjAv+2f9eNNtEGCeLQeM4pOPwPJT+A+aKJa69fq6pvWqFqih+YTZsXbbVF
        KI0Q90Cf1UKFSLOBJveAK/DlpM8DO8W+8t9FmIHHfwwbjh/dN0CkBGbPTuJGvnGHhmr9238mm1Q
        XaIrWncO1oHRChDtjynqv1hVDlo9PfXLU39GOm+sfkPrj7CaqXpSxZKDDzFgLDzQJD3kt0DFA5d
        FB9NsjmPP9edzaP5qx6frpJFf/MOEt1Iuwj4gXsZIjJc0QK/Yyep+wopoUNa3/rEOakn8sT0BRZ
        NI+YwbANog326X8vgFaXg5vJyaC8J0BxWW1D95qBJKosT8FWDnxJqun3snzJQhrLH5KSJ0=
X-TMASE-XGENCLOUD: 2a743da6-ac22-4058-955b-c93c50018bcc-0-0-200-0
X-TM-Deliver-Signature: 3643810533B55FE489482FDFA1BD4FCE
X-TM-Addin-Auth: Q7PgLWEeSdzvCNfWq2rJPuhGUJCD88VJzCDy377dGoz1njPjMAh3WgItGne
        E2wE2oTIs+WW/VFGKtU5qo0uaSIMvaNWsusYYsg7xZ16AWgGe7uknGkVdNqPbN0TkCaRAMinZLd
        uQyd1n5dR965J55dEUDnXJuLof2efX6L1QU6BtB3WYkC2SrmyeK9h1cVe7gl1BApvd9ZunZNpyh
        P5Ka9NQPiuBPMI8Ina/T7O62VxTKrFRzhjMo9j5l+0mShbgFhEyHw4hwxgoR3F1dVWTpEvBJH90
        hXq66OY1Qh33e5g=.Jt4xSX+jWK2BJvivHcC4QNTr169gz/W6he7aZGC2L96bcpqS6RY1NZSqBK
        niEQGL/5j6GsfdRhQZwLOcQwzYzxw00SVjvg35OPvszWlGedUFEafCsxwpdJq2gyKmE4PR1ilRX
        +1pa7R2UgWurVtBwTA0bi3zeCUhrPuWrI7Jld/L1UJQe6JxXi//6OAjxA/XApIN55duhcv3KXAP
        x9oOZxkfe/OwQp+DtOljscCvKlyiW4TuYqA1nt2iHRTPn5KVz2pyKDCBRnPmRGC1T6PQP1wfRmU
        H0CDlhPVHQ9z47T7kVDGsk965W8D5KMicZNnEFqTQL67e7QNsBowgUNMUNA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1688145151;
        bh=Wl+SLhjbrbxWDdL7TjpfJUiywTbYu/HsOyULxhWqCDA=; l=8586;
        h=From:To:Date;
        b=xIZgv9Mp5fcfNUAM51asPNipC/MOFFbXWjFCQSEKPWB5Q0H90PYC2CvQy8UGoH57+
         /HQcxHo/GFnJT0A4jjvUBTQ1oo8QqS27KT3BWc9iAs+6wK5z0QSg1ERtvXKFrohZbW
         MaQZormkb74FYKHCoDXFMbJ5nieYpg5u6dJPo0dtdXbOCHPhu2lSqE+sOOyuYmJSTl
         DS3JJB3olBTOCRK4ufj3lbULiorEO2Ub5qN0MIPCN2jMZ3vqGecc2Vze0NdSxnxZV6
         0jGVsOWmNPnNb1YB10335LaHBcS85Txe1wkzMD7TBjNLYkvSdzdMuke2qflvs4jK04
         v89HNHxGJN3Kg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the virtio_rtc module, and related bugfixes and
small interface extensions. The virtio_rtc module implements a driver
compatible with the proposed Virtio RTC device specification [1]. The
Virtio RTC (Real Time Clock) device provides information about current
time. The device can provide different clocks, e.g. for the UTC or TAI time
standards, or for physical time elapsed since some past epoch. The driver
can read the clocks with simple or more accurate methods.

This patch series depends, through its arm_arch_timer patch, on patch
"arm64/arch_timer: Provide noinstr sched_clock_read() functions" [3] which
seems not to be available with all development branches yet. Pull [2] for
an equivalent series on top of mst/linux-next, which should apply without
the above patch. Pull [5] for an equivalent series on top of
tip/timers/core. Pull [6] for an equivalent series on top of
tip/sched/core.

The series first fixes some bugs in the get_device_system_crosststamp()
interpolation code, which is required for reliable virtio_rtc operation.
Next, expose some Arm Generic Timer clocksource details for virtio_rtc.
Last, add the virtio_rtc implementation.

For the Virtio RTC device, there is currently a proprietary implementation,
which has been used for provisional testing.

virtio_rtc exposes clocks as PTP clocks to userspace, similar to ptp_kvm.
If both the Virtio RTC device and this driver have special support for the
current clocksource, time synchronization programs can use
cross-timestamping using ioctl PTP_SYS_OFFSET_PRECISE2 aka
PTP_SYS_OFFSET_PRECISE. Similar to ptp_kvm, system time synchronization
with single-digit ns precision is possible with a quiescent reference clock
(from the Virtio RTC device). This works even when the Virtio device
response is slow compared to ptp_kvm hypercalls.

The following illustrates a test using PTP_SYS_OFFSET_PRECISE, with
interspersed strace log and chrony [4] refclocks log, on arm64. In the
example, chrony tracks a virtio_rtc PTP clock ("PHCV", /dev/ptp0). The raw
offset between the virtio_rtc clock and CLOCK_REALTIME is 0 to 1 ns. At the
device side, the Virtio RTC device artificially delays both the clock read
request, and the response, by 50 ms. Cross-timestamp interpolation still
works with this delay. chrony also monitors a ptp_kvm clock ("PHCK",
/dev/ptp3) for comparison, which yields a similar offset.

	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000329>
	===============================================================================
	   Date (UTC) Time         Refid  DP L P  Raw offset   Cooked offset      Disp.
	===============================================================================
	2023-06-29 18:49:55.595742 PHCK    0 N 0  1.000000e-09  8.717931e-10  5.500e-08
	2023-06-29 18:49:55.595742 PHCK    - N -       -        8.717931e-10  5.500e-08
	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101545>
	2023-06-29 18:49:56.147766 PHCV    0 N 0  1.000000e-09  8.801870e-10  5.500e-08
	2023-06-29 18:49:56.147766 PHCV    - N -       -        8.801870e-10  5.500e-08
	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000195>
	2023-06-29 18:49:56.202446 PHCK    0 N 0  1.000000e-09  7.364180e-10  5.500e-08
	2023-06-29 18:49:56.202446 PHCK    - N -       -        7.364180e-10  5.500e-08
	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101484>
	2023-06-29 18:49:56.754641 PHCV    0 N 0  0.000000e+00 -2.617368e-10  5.500e-08
	2023-06-29 18:49:56.754641 PHCV    - N -       -       -2.617368e-10  5.500e-08
	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000270>
	2023-06-29 18:49:56.809282 PHCK    0 N 0  1.000000e-09  7.779321e-10  5.500e-08
	2023-06-29 18:49:56.809282 PHCK    - N -       -        7.779321e-10  5.500e-08
	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101510>
	2023-06-29 18:49:57.361376 PHCV    0 N 0  0.000000e+00 -2.198794e-10  5.500e-08
	2023-06-29 18:49:57.361376 PHCV    - N -       -       -2.198794e-10  5.500e-08

This patch series only adds special support for the Arm Generic Timer
clocksource. At the driver side, it should be easy to support more
clocksources.

Without special support for the current clocksource, time synchronization
programs can still use ioctl PTP_SYS_OFFSET_EXTENDED2 aka
PTP_SYS_OFFSET_EXTENDED. In this case, precision will generally be worse
and will depend on the Virtio device response characteristics.

The following illustrates a test using PTP_SYS_OFFSET_EXTENDED, with
interspersed strace log and chrony refclocks log, on x86-64 (with `ts'
values omitted):

	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	===============================================================================
	   Date (UTC) Time         Refid  DP L P  Raw offset   Cooked offset      Disp.
	===============================================================================
	2023-06-28 14:11:26.697782 PHCV    0 N 0  3.318200e-05  3.450891e-05  4.611e-06
	2023-06-28 14:11:26.697782 PHCV    - N -       -        3.450891e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:27.208763 PHCV    0 N 0 -3.792800e-05 -4.023965e-05  4.611e-06
	2023-06-28 14:11:27.208763 PHCV    - N -       -       -4.023965e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:27.722818 PHCV    0 N 0 -3.328600e-05 -3.134404e-05  4.611e-06
	2023-06-28 14:11:27.722818 PHCV    - N -       -       -3.134404e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:28.233572 PHCV    0 N 0 -4.966900e-05 -4.584331e-05  4.611e-06
	2023-06-28 14:11:28.233572 PHCV    - N -       -       -4.584331e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:28.742737 PHCV    0 N 0  4.902700e-05  5.361388e-05  4.611e-06
	2023-06-28 14:11:28.742737 PHCV    - N -       -        5.361388e-05  4.611e-06

The following udev rule can be used to get a symlink /dev/ptp_virtio to the
UTC clock:

	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP UTC", SYMLINK += "ptp_virtio"

The following chrony configuration directive can then be added in
/etc/chrony/chrony.conf to synchronize to the Virtio UTC clock:

	refclock PHC /dev/ptp_virtio refid PHCV poll -1 dpoll -1

This patch series adds virtio_rtc not in drivers/ptp, but as a generic
Virtio driver. In the near future, virtio_rtc should be extended with an
RTC Class driver, along with extensions to the Virtio RTC device draft spec
to support RTC alarms.

Feedback is greatly appreciated.

[1] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00592.html
[2] https://github.com/OpenSynergy/linux virtio-rtc-v1-on-mst-vhost-linux-next
[3] https://lore.kernel.org/r/20230519102715.435618812@infradead.org
[4] https://chrony.tuxfamily.org/
[5] https://github.com/OpenSynergy/linux virtio-rtc-v1-on-tip-timers-core
[6] https://github.com/OpenSynergy/linux virtio-rtc-v1-on-tip-sched-core


Peter Hilber (7):
  timekeeping: Fix cross-timestamp interpolation on counter wrap
  timekeeping: Fix cross-timestamp interpolation corner case decision
  timekeeping: Fix cross-timestamp interpolation for non-x86
  clocksource: arm_arch_timer: Export counter type, clocksource
  virtio_rtc: Add module and driver core
  virtio_rtc: Add PTP clocks
  virtio_rtc: Add Arm Generic Timer cross-timestamping

 MAINTAINERS                          |   7 +
 drivers/clocksource/arm_arch_timer.c |  16 +
 drivers/virtio/Kconfig               |  43 ++
 drivers/virtio/Makefile              |   4 +
 drivers/virtio/virtio_rtc_arm.c      |  44 ++
 drivers/virtio/virtio_rtc_driver.c   | 841 +++++++++++++++++++++++++++
 drivers/virtio/virtio_rtc_internal.h |  85 +++
 drivers/virtio/virtio_rtc_ptp.c      | 384 ++++++++++++
 include/clocksource/arm_arch_timer.h |  19 +
 include/uapi/linux/virtio_rtc.h      | 159 +++++
 kernel/time/timekeeping.c            |  20 +-
 11 files changed, 1615 insertions(+), 7 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_arm.c
 create mode 100644 drivers/virtio/virtio_rtc_driver.c
 create mode 100644 drivers/virtio/virtio_rtc_internal.h
 create mode 100644 drivers/virtio/virtio_rtc_ptp.c
 create mode 100644 include/uapi/linux/virtio_rtc.h


base-commit: 6352a698ca5bf26a9199202666b16cf741f579f6
-- 
2.39.2

